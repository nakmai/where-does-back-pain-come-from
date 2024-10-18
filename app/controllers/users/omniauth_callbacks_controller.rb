# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # Google OAuth 2.0 認証データを取得
    auth = request.env['omniauth.auth']

    # Googleからの必要データを抽出
    google_data = extract_google_data(auth)
    session[:google_data] = google_data

    # ユーザーをOmniAuthのデータを基に検索または新規作成
    @user = User.from_omniauth(auth)

    if @user.persisted?
      # 退会済みのアカウントが存在する場合、`deleted_at`をリセット
      reactivate_user_if_deleted(@user)

      # ユーザーが正常に保存されていればサインインし、リダイレクト
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      flash[:notice] = "登録が完了しました。生年月日や性別を後で入力してください。"

      # 年齢・性別に基づくリダイレクト
      age = calculate_age(google_data[:birthdate])
      redirect_based_on_age_and_gender(age, google_data[:gender])
    else
      # ユーザーが保存されない場合、エラーメッセージとともに登録ページにリダイレクト
      session['devise.google_data'] = auth.except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  private

  def extract_google_data(auth)
    {
      birthdate: auth.extra&.raw_info&.birthday || auth.extra&.raw_info&.birthdate || auth.info&.dob,
      gender: auth.extra&.raw_info&.gender || auth.info&.gender
    }
  end

  def reactivate_user_if_deleted(user)
    if user.deleted_at.present?
      user.update(deleted_at: nil)
    end
  end

  def calculate_age(birthdate)
    return nil unless birthdate
    ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
  end

  def redirect_based_on_age_and_gender(age, gender)
    return redirect_to root_path, alert: "無効な年齢データです。" unless age

    case age
    when 0..20, 55..150
      redirect_to orthopedics_advice1_path
    when 21..54
      if gender == "male"
        redirect_to red_flag_path
      elsif gender == "female"
        redirect_to gynecology_question_path
      else
        redirect_to root_path, alert: "無効な性別データです。"
      end
    else
      redirect_to root_path, alert: "無効な年齢データです。"
    end
  end
end

