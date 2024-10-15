
# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # Google OAuth2のコールバック処理
  def google_oauth2
    # Google認証情報を元にユーザーを検索または新規作成
    @user = User.from_omniauth(request.env['omniauth.auth'])

    # ユーザーがデータベースに存在し、保存されている場合
    if @user.persisted?
      if @user.birthday.present? && @user.gender.present?
        # 生年月日と性別が既に登録されている場合は通常通りログイン後のページにリダイレクト
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      else
        # 生年月日や性別が登録されていない場合はフォームページにリダイレクト
        sign_in @user
        redirect_to users_all_form_path
      end
    else
      # ユーザーが作成されなかった場合は、新規登録ページにリダイレクトし、エラーメッセージを表示
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  # 認証に失敗した場合の処理
  def failure
    redirect_to root_path
  end
end

  
  
  