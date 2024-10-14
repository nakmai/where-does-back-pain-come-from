class PasswordsController < Devise::PasswordsController
  # 1. パスワードリセットメール送信後のリダイレクト先をカスタマイズ
  def create
    super
  end

  # 2. パスワードリセット用URLクリック時の処理
  def edit
    # トークンを用いてリソースを探す
    self.resource = resource_class.with_reset_password_token(params[:reset_password_token])

    # リソースが見つからない場合
    if resource.nil?
      flash.now[:alert] = "パスワードリセットトークンが無効です。もう一度試してください。"
      self.resource = resource_class.new # 空のリソースを設定してフォームの再表示を可能にする
    else
      # トークンが見つかった場合はパスワードリセットトークンを設定
      resource.reset_password_token = params[:reset_password_token]
    end

    # リソースがあってもなくても同じビューをレンダリング
    render :edit
  end

  # 3. 新しいパスワードを設定後の処理
  def update
    if params[:user][:password] != params[:user][:password_confirmation]
      flash.now[:alert] = "パスワードが一致していません"
      render :edit and return
    end

    if params[:user][:password].length < 6 || params[:user][:password].length > 20 ||
       !(params[:user][:password] =~ /[A-Z]/ && params[:user][:password] =~ /[a-z]/ && params[:user][:password] =~ /\d/)
      flash.now[:alert] = "6文字以上〜20文字以内で小文字・大文字・数字を組み合わせたパスワードを設定してください"
      render :edit and return
    end

    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      yield resource if block_given?
      set_flash_message!(:notice, :updated_not_active)
      flash.now[:notice] = "パスワードが正常に変更されました。再度ログインしてください。"
      render :edit
    else
      flash.now[:alert] = resource.errors.full_messages.join(", ")
      render :edit
    end
  end

  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    new_user_session_path
  end
end



  