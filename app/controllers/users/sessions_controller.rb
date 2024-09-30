class Users::SessionsController < Devise::SessionsController
    # GET /resource/sign_in
    def new
      super
    end
  
    # DELETE /resource/sign_out
    def destroy
      super
    end
  
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
  end
  
