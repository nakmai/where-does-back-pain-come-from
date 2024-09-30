class Users::RegistrationsController < Devise::RegistrationsController
    def create
      if params[:user][:nickname].blank?
        flash[:alert] = "ニックネームを入力してください"
        redirect_to new_user_registration_path and return
      elsif params[:year].blank? || params[:month].blank? || params[:day].blank?
        flash[:alert] = "生年月日を入力してください"
        redirect_to new_user_registration_path and return
      elsif params[:user][:gender].blank?
        flash[:alert] = "性別を選択してください"
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
  
