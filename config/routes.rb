Rails.application.routes.draw do
  # Devise のルーティング設定
  devise_for :users
  
  # ホームページ
  get 'home/index'
  
  # ログアウト完了ページのルート
  get 'logout_complete', to: 'home#logout_complete'
  
  # ルートページ ("/")
  root 'home#index'
end


