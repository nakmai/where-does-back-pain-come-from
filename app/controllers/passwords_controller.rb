class PasswordsController < Devise::PasswordsController
  # 1. パスワードリセットメール送信後のリダイレクト先をカスタマイズ
  def create
    super
  end

  # 2. パスワードリセット用URLクリック時の処理
  def update
    # パスワードと確認が一致しない場合のエラーハンドリング
    if params[:user][:password] != params[:user][:password_confirmation]
      flash.now[:alert] = "パスワードが一致していません"
      self.resource = resource_class.new # リソースを再設定
      render :edit and return
    end
  
    # パスワードの形式チェック
    if params[:user][:password].length < 6 || params[:user][:password].length > 20 ||
       !(params[:user][:password] =~ /[A-Z]/ && params[:user][:password] =~ /[a-z]/ && params[:user][:password] =~ /\d/)
      flash.now[:alert] = "6文字以上〜20文字以内で小文字・大文字・数字を組み合わせたパスワードを設定してください"
      self.resource = resource_class.new # リソースを再設定
      render :edit and return
    end
  
    # パスワードリセットをトークンで行う
    self.resource = resource_class.reset_password_by_token(resource_params)
  
    # パスワードリセットが成功した場合
    if resource.errors.empty?
      yield resource if block_given?
      set_flash_message!(:notice, :updated_not_active)
      flash.now[:notice] = "パスワードが正常に変更されました。再度ログインしてください。"
      render :edit
    else
      # リソースがエラーを持っている場合
      flash.now[:alert] = resource.errors.full_messages.join(", ")
      self.resource ||= resource_class.new # リソースがnilの場合は新しいインスタンスを設定
      render :edit
    end
  end

  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    new_user_session_path
  end
end



  