class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
      root_path # ログイン後にルートページにリダイレクト
    end
  
    def after_sign_out_path_for(resource_or_scope)
      root_path # ログアウト後もルートページにリダイレクト
    end
  end
  
