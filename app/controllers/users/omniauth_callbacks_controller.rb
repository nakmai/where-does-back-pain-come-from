# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
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

        # 年齢・性別に基づくリダイレクト先を決定
        age = calculate_age(google_data[:birthdate])
        determine_redirect_path_based_on_age_and_gender(age, google_data[:gender])

        # ユーザーをサインインし、リダイレクト先にリダイレクト
        sign_in @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
        flash[:notice] = '登録が完了しました。'
        redirect_to root_path
      else
        # ユーザーが保存されない場合、エラーメッセージとともに登録ページにリダイレクト
        session['devise.google_data'] = auth.except(:extra)
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join('\n')
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
      return unless user.deleted_at.present?

      user.update(deleted_at: nil)
    end

    def calculate_age(birthdate)
      return nil unless birthdate

      ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
    end

    public
    
    def determine_redirect_path_based_on_age_and_gender(age, gender)
      return root_path, alert: '無効な年齢データです。' unless age

      case age
      when 0..20, 55..150
        orthopedics_advice1_path
      when 21..54
        if gender == 'male'
          red_flag_path
        elsif gender == 'female'
          gynecology_question_path
        else
          redirect_to root_path, alert: '無効な性別データです。'
        end
      else
        redirect_to root_path, alert: '無効な性別データです。'
      end
    end
  end
end
