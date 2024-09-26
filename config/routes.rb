Rails.application.routes.draw do
  # Devise のルーティング設定
  devise_for :users
  
  # ホームページ
  get 'home/index'

  # ログイン後のページ
  get 'after_sign_in', to: 'home#after_sign_in'

    # ログアウト完了ページ
  get 'logout_complete', to: 'home#logout_complete'

  # ルートページ ("/")
  root 'home#index'

  # 規約ページへのルート
  get 'terms', to: 'pages#terms'
  
end



