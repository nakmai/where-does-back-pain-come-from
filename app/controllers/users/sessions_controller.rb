# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # GET /resource/sign_in

    # DELETE /resource/sign_out

    # ログイン処理
    def create
      if params[:user][:email].blank?
        flash[:alert] = 'メールアドレスを入力してください'
        redirect_to new_user_session_path and return
      elsif params[:user][:password].blank?
        flash[:alert] = 'パスワードを入力してください'
        redirect_to new_user_session_path and return
      else
        super
      end
    end

    # ログイン後のリダイレクト先
    def after_sign_up_path_for(_resource)
      root_path # ここでリダイレクト先を固定する
    end

    # ログアウト後のリダイレクト先
    def after_sign_out_path_for(_resource_or_scope)
      root_path # ログアウト後は root_path にリダイレクト
    end
  end
end
