Rails.application.routes.draw do
  # Devise のルーティング設定
  devise_for :users

  # ユーザー関連ルート
  resources :users, only: [:create] 
  
  # ホームページ
  get 'home/index'

  # ログイン後のページ
  get 'after_sign_in', to: 'home#after_sign_in'

  # ログアウト完了ページ
  get 'logout_complete', to: 'home#logout_complete'

  # all_form ページへのルート
  get 'users/all_form', to: 'users#all_form'
  post 'users/submit_form', to: 'users#submit_form'  # submit_form への POST リクエスト

  # 規約ページへのルート
  get 'terms', to: 'pages#terms'

  # 整形外科受診催促ページへのルート
  get 'orthopedics_advice', to: 'orthopedics#orthopedics_advice'

  # レッドフラッグページへのルート
  get 'red_flag', to: 'pages#red_flag'

  # 婦人科に関する質問ページへのルート
  get 'gynecology_question', to: 'gynecology#gynecology_question'
  post 'submit_gynecology_question', to: 'gynecology#submit_gynecology_question'


  # 婦人科受診催促 ページへのルート
  get 'gynecology_advice', to: 'gynecology#gynecology_advice'

  # ルートページ ("/")
  root 'home#index'
end




