class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception  

    def after_sign_in_path_for(resource)
      after_sign_in_path # ログイン後に after_sign_in ページにリダイレクト
      stored_location_for(resource_or_scope) || root_path
    end
    
    def after_sign_out_path_for(resource_or_scope)
        logout_complete_path # ログアウト後はログアウト完了ページにリダイレクト
    end

    private
    
      # ユーザーがアクセスしたページのURLを保存
    def store_user_location!
      store_location_for(:user, request.fullpath)
    end

  # 保存するべきリクエストかどうかを判定
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end
  end
  
  
