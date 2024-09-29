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
  post 'users/submit_form', to: 'users#submit_form'

  # 規約ページへのルート
  get 'terms', to: 'pages#terms'

  # 整形外科受診催促ページへのルート
  get 'orthopedics_advice1', to: 'orthopedics#orthopedics_advice1', as: 'orthopedics_advice1'
  get 'orthopedics_advice2', to: 'orthopedics#orthopedics_advice2', as: 'orthopedics_advice2'
  get 'orthopedics_advice3', to: 'orthopedics#orthopedics_advice3', as: 'orthopedics_advice3'
  get 'orthopedics_advice5', to: 'orthopedics#orthopedics_advice5', as: 'orthopedics_advice5'

  # レッドフラッグページ処理
  get 'red_flag', to: 'pain#red_flag'
  post 'red_flag_submit', to: 'pain#submit_red_flag', as: 'red_flag_submit'

  # gynecology_controllerのチェック処理に関連するルート
  post 'gynecology/check', to: 'gynecology#check', as: 'gynecology_check'

  # レッドフラッグ２のフォームページと処理
  get 'red_flag2', to: 'pain#red_flag2', as: 'red_flag2'  
  post 'red_flag2_submit', to: 'pain#red_flag2_submit', as: 'red_flag2_submit'

  # 婦人科に関する質問ページへのルート
  get 'gynecology_question', to: 'gynecology#gynecology_question'
  post 'submit_gynecology_question', to: 'gynecology#submit_gynecology_question'

  # 婦人科受診催促 ページへのルート
  get 'gynecology_advice', to: 'gynecology#gynecology_advice'

  # 特に問題がない場合のリダイレクト先
  get 'pages/red_flag', to: 'pages#red_flag'

  #ペインスケール画面
  get 'pain_scale', to: 'pain#pain_scale', as: 'pain_scale'
  post 'pain/submit_pain_scale', to: 'pain#submit_pain_scale'
 
  # 痛みの強さが6以上の場合のリダイレクト先 orthopedics_advice5
  get 'orthopedics_advice5', to: 'orthopedics#orthopedics_advice5'

  # 痛みの強さが5以下の場合のリダイレクト先 achlorhydria
  get 'achlorhydria', to: 'diagnosis#achlorhydria'

  # ルートページ ("/")
  root 'home#index'
end

