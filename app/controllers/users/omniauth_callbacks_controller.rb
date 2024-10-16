# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth = request.env['omniauth.auth']

    # Googleからのデータを取得してセッションに保存
    google_data = extract_google_data(auth)
    session[:google_data] = google_data

    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      
      # 生年月日と性別がある場合のリダイレクト処理
      if google_data[:birthdate].present? && google_data[:gender].present?
        birthdate = Date.parse(google_data[:birthdate]) rescue nil
        if birthdate
          age = calculate_age(birthdate)
          redirect_based_on_age_and_gender(age, google_data[:gender])
          return  
        end
      end
      
      # 生年月日や性別がなければ入力フォームへ
      redirect_to all_form_users_path
      return  
    else
      session['devise.google_data'] = auth.except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  private

  def extract_google_data(auth)
    {
      birthdate: auth.extra.raw_info.birthday || auth.extra.raw_info.birthdate,
      gender: auth.extra.raw_info.gender
    }
  end

  def calculate_age(birthdate)
    ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
  end

  def redirect_based_on_age_and_gender(age, gender)
    if age <= 20 || age >= 55
      redirect_to orthopedics_advice1_path
    elsif age >= 21 && age <= 54
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
