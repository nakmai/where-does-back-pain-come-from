class Users::RegistrationsController < Devise::RegistrationsController
  def create
    if request.get?
      redirect_to new_user_registration_path and return
    end

    # ユーザーデータが存在しない場合
    if params[:user].nil?

      redirect_to new_user_registration_path and return
    # 両方のフィールドが空の場合
    elsif params[:user][:email].blank? && params[:user][:password].blank?
      flash[:alert] = "メールアドレスとパスワードを入力してください"
      redirect_to new_user_registration_path and return
    # メールアドレスが空の場合
    elsif params[:user][:email].blank?
      flash[:alert] = "メールアドレスを入力してください"
      redirect_to new_user_registration_path and return
    # パスワードが空の場合
    elsif params[:user][:password].blank?
      flash[:alert] = "パスワードを入力してください"
      redirect_to new_user_registration_path and return
    else
      # Deviseの標準の登録処理を行う
      super
    end
  end

  def new
    super # Deviseの新規登録フォームを表示
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end

  def after_sign_up_path_for(resource)
    user_my_page_path(resource)
  end
end

