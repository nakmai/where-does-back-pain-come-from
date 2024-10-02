class Users::RegistrationsController < Devise::RegistrationsController
    def create
      if params[:user][:nickname].blank?
        flash[:alert] = "ニックネームを入力してください"
        redirect_to new_user_registration_path and return
      elsif params[:user][:email].blank?
        flash[:alert] = "メールアドレスを入力してください"
        redirect_to new_user_registration_path and return
      elsif params[:user][:password].blank?
        flash[:alert] = "パスワードを入力してください"
        redirect_to new_user_registration_path and return
      else
        super  # Deviseの登録アクションを呼び出す
      end
    end
  end
  
