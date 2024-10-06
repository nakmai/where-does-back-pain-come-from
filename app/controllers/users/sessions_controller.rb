class Users::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # ログイン処理
  def create
    if params[:user][:email].blank?
      flash[:alert] = "メールアドレスを入力してください"
      redirect_to new_user_session_path and return
    elsif params[:user][:password].blank?
      flash[:alert] = "パスワードを入力してください"
      redirect_to new_user_session_path and return
    else
      super
    end
  end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    if params[:return_to].present?
      return params[:return_to]
    end
    # 保存された場所があればそこにリダイレクト、なければ root_path
    stored_location_for(resource) || root_path
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    root_path # ログアウト後は root_path にリダイレクト
  end

end

  
