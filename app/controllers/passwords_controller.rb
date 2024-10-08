class PasswordsController < Devise::PasswordsController
    # 1. パスワードリセットメール送信後のリダイレクト先をカスタマイズ
    def create
      # 標準のDeviseのメール送信処理を実行
      super
    end
  
    # 2. パスワードリセット用URLクリック時の処理
    # Deviseのeditアクションが呼び出され、パスワード変更フォームが表示される
    def edit
      # 標準のDeviseのeditアクションを実行
      super
    end
  
    # 3. 新しいパスワードを設定後の処理
    def update
      # パスワード更新処理を実行
      self.resource = resource_class.reset_password_by_token(resource_params)
      
      # パスワードが無事に変更されたかどうかを確認
      if resource.errors.empty?
        # ログインさせず、パスワード変更後にログインページへリダイレクトする
        yield resource if block_given?
        set_flash_message!(:notice, :updated_not_active) # Deviseが提供するメッセージを表示
        redirect_to new_user_session_path # 4. 登録完了後にログインページにリダイレクト
      else
        # エラーがあれば再度パスワード変更ページを表示
        respond_with resource
      end
    end
  
    protected
  
    # メール送信後のリダイレクト先をカスタマイズ
    def after_sending_reset_password_instructions_path_for(resource_name)
      # メール送信後にリダイレクトするパス
      new_user_session_path # 例として、ログインページにリダイレクト
    end
  
    # パスワード変更後のリダイレクト先をカスタマイズ
    def after_resetting_password_path_for(resource)
      # パスワードリセット完了後のリダイレクト先
      new_user_session_path # ログインページにリダイレクト
    end
  end
  