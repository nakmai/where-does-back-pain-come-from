class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception  

    def after_sign_in_path_for(resource)
      after_sign_in_path # ログイン後に after_sign_in ページにリダイレクト
    end
    
    def after_sign_out_path_for(resource_or_scope)
        logout_complete_path # ログアウト後はログアウト完了ページにリダイレクト
    end
    
  end
  
  
