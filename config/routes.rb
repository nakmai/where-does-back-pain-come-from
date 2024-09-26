Rails.application.routes.draw do
  # Devise のルーティング設定
  devise_for :users
  
  # ホームページ
  get 'home/index'
  
  # ルートページ ("/")
  root 'home#index'
end


