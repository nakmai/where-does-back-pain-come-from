
# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth = request.env['omniauth.auth']

    # Google People API から生年月日と性別を取得するために、APIレスポンスを保存
    google_data = extract_google_data(auth)
    session[:google_data] = google_data

    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      session['devise.google_data'] = auth.except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def extract_google_data(auth)
    {
      birthdate: auth.extra.raw_info.birthdate || auth.extra.raw_info.birthdate,
      gender: auth.extra.raw_info.gender
    }
  end
end