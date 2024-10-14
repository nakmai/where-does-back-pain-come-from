
module Users
  class RegistrationsController < Devise::RegistrationsController

    def new
      # Devise の標準の new メソッドを使って resource を初期化
      build_resource({})
      super
    end

    def create
      # ユーザーデータが存在しない場合
      if params[:user].nil?
        redirect_to new_user_registration_path and return
      end

      # 生年月日を結合して birthdate を作成
      begin
        birthdate = Date.new(
          params[:user][:birthdate_year].to_i,
          params[:user][:birthdate_month].to_i,
          params[:user][:birthdate_day].to_i
        )
      rescue ArgumentError
        flash.now[:alert] = "無効な日付です"
        build_resource(sign_up_params)  # resource を保持
        render :new and return
      end

        # 生年月日が未来の日付かを確認
      if birthdate > Date.today
         flash.now[:alert] = "無効な日付です"
         build_resource(sign_up_params)
          render :new and return
      end

        # 性別が選択されていない場合の処理
      if params[:user][:gender].blank?
        flash.now[:alert] = "性別を選択してください"
        build_resource(sign_up_params)
        render :new and return
      end

      # メールアドレスまたはパスワードが空の場合の処理
      if params[:user][:email].blank?
        flash.now[:alert] = "メールアドレスを入力してください"
        build_resource(sign_up_params)  # resource を保持
        render :new and return
      elsif params[:user][:password].blank?
        flash.now[:alert] = "パスワードを入力してください"
        build_resource(sign_up_params)  # resource を保持
        render :new and return
      end

      # メールアドレスが既に存在するかの確認
      if User.exists?(email: params[:user][:email].downcase)
        flash.now[:alert] = "すでに登録されているメールアドレスです"
        build_resource(sign_up_params)  # resource を保持
        render :new and return
      end

      # パスワードの長さと構成の確認
      if params[:user][:password].length < 6 || params[:user][:password].length > 20 ||
         !(params[:user][:password] =~ /[A-Z]/ && params[:user][:password] =~ /[a-z]/ && params[:user][:password] =~ /\d/)
        flash.now[:alert] = "6文字以上〜20文字以内で小文字・大文字・数字を組み合わせたパスワードを設定してください"
        build_resource(sign_up_params)  # resource を保持
        render :new and return
      end

      # パスワードの一致確認
      if params[:user][:password] != params[:user][:password_confirmation]
        flash.now[:alert] = "パスワードが一致していません"
        build_resource(sign_up_params)  # resource を保持
        render :new and return
      end

      # sign_up_params をマージしてユーザーリソースを作成
      @user = build_resource(sign_up_params.merge(birthdate: birthdate))

      # Devise の標準登録処理を使用
      if resource.save
        flash[:notice] = "登録されました"
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        build_resource(sign_up_params)  # エラー時に resource を保持
        render :new
      end
    end

    protected

    def after_sign_up_path_for(resource)
      root_path
    end

    private

    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :gender)
    end

    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :birthdate, :gender)
    end
  end
end

