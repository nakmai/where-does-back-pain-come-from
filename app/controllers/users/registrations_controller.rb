module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
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
        # メールアドレスがすでに存在する場合の処理
        if User.exists?(email: params[:user][:email].downcase)
          flash[:alert] = "すでに登録されています"
          redirect_to new_user_registration_path and return
        end
        
        # Deviseの標準の登録処理を行い、成功した場合にフラッシュメッセージを表示
        super do |resource|
          if resource.persisted? # 登録成功
            flash[:notice] = "登録されました"
          end
        end
      end
    end
  
    # Deviseの新規登録フォームを表示
    def new
      super
    end

    protected

    # 新規登録後のリダイレクト先を決定
    def after_sign_up_path_for(resource)
      # セッションに保存されたURLがあればそこにリダイレクト
      stored_location = session[:user_return_to]
      if stored_location.present?
        session.delete(:user_return_to) # 一度リダイレクトしたらセッションから削除
        stored_location
      else
        # トップページから来た場合は特定のページにリダイレクト
        after_sign_in_path
      end
    end

    private

    # 新規登録時に許可するパラメータ
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    # アカウント更新時に許可するパラメータ
    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
    end
  end
end
