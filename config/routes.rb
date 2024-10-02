Rails.application.routes.draw do
  # Devise のルーティング設定
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # ユーザー関連ルート
  resources :users, only: [:create] do
    collection do
      get 'all_form'
      post 'submit_form'
    end
  end

  # ホームページとログイン後のページ
  root 'home#index'
  get 'home/index'
  get 'after_sign_in', to: 'home#after_sign_in'
  get 'logout_complete', to: 'home#logout_complete'
  get 'users/my_page', to: 'users#my_page', as: :my_page

  # 規約ページへのルート
  get 'terms', to: 'pages#terms'

  # 整形外科関連のルート
  get 'orthopedics_advice1', to: 'orthopedics#orthopedics_advice1'
  get 'orthopedics_advice2', to: 'orthopedics#orthopedics_advice2'
  get 'orthopedics_advice3', to: 'orthopedics#orthopedics_advice3'
  get 'orthopedics_advice5', to: 'orthopedics#orthopedics_advice5'
  get 'orthopedics_advice6', to: 'orthopedics#orthopedics_advice6'

  # ペインスケール関連
  get 'pain_scale', to: 'pain#pain_scale'
  post 'pain/submit_pain_scale', to: 'pain#submit_pain_scale'

  # レッドフラッグ関連
  get 'red_flag', to: 'pain#red_flag'
  post 'red_flag', to: 'pain#submit_red_flag'
  get 'red_flag2', to: 'pain#red_flag2'
  post 'red_flag2_submit', to: 'pain#red_flag2_submit'

  # 婦人科に関するルート
  get 'gynecology_question', to: 'gynecology#gynecology_question'
  post 'submit_gynecology_question', to: 'gynecology#submit_gynecology_question'
  post 'gynecology/check', to: 'gynecology#check', as: 'gynecology_check'
  get 'gynecology_advice', to: 'gynecology#gynecology_advice'

  # 診断関連のルート
  resources :diagnosis do
    collection do
      get 'extention', to: 'pain_location#extention'
      get 'flexion', to: 'pain_location#flexion'
      get 'extention_flexion', to: 'pain_location#extention_flexion'
    end
  end

  # 痛みの場所関連のルート
  get 'pain_location_extention', to: 'pain_location_extention#extention', as: 'pain_location_extention'
  post 'pain_location_extention', to: 'pain_location_extention#extention'

  get 'pain_location_extention_flexion', to: 'pain_location_extention_flexion#extention_flexion', as: 'pain_location_extention_flexion'
  post 'pain_location_extention_flexion', to: 'pain_location_extention_flexion#extention_flexion'

  get 'pain_location_flexion', to: 'pain_location_flexion#flexion', as: 'pain_location_flexion'
  post 'pain_location_flexion/submit', to: 'pain_location_flexion#submit_flexion', as: 'submit_pain_location_flexion'

  # 各疾患特徴関連のルート
  get 'pain_behavior_myofascial_back_pain', to: 'pain_behavior_flexion#pain_behavior_myofascial_back_pain'
  post 'pain_behavior_myofascial_back_pain', to: 'pain_behavior_flexion#pain_behavior_myofascial_back_pain'

  get 'pain_behavior_intervertebral_disk', to: 'pain_behavior_flexion#pain_behavior_intervertebral_disk'
  post 'pain_behavior_intervertebral_disk', to: 'pain_behavior_flexion#pain_behavior_intervertebral_disk'

  get 'pain_behavior_sacroiliac_joint', to: 'pain_behavior_flexion#pain_behavior_sacroiliac_joint'
  post 'pain_behavior_sacroiliac_joint', to: 'pain_behavior_flexion#pain_behavior_sacroiliac_joint'

  get 'pain_behavior_sacroiliac_joint2', to: 'pain_behavior_flexion#sacroiliac_joint2'
  post 'pain_behavior_sacroiliac_joint2', to: 'pain_behavior_flexion#sacroiliac_joint2'

  get 'pain_behavior_intervertebral_joint', to: 'pain_behavior_flexion#pain_behavior_intervertebral_joint'
  post 'pain_behavior_intervertebral_joint', to: 'pain_behavior_flexion#pain_behavior_intervertebral_joint'

  # 診断結果関連のルート
  get 'diagnostic_result_myofascial_back_pain', to: 'diagnostic_result#myofascial_back_pain' 
  post 'diagnostic_result_myofascial_back_pain', to: 'diagnostic_result#myofascial_back_pain'

  get 'diagnostic_result_sacroiliac_joint', to: 'diagnostic_result#sacroiliac_joint', as: 'diagnostic_result_sacroiliac_joint'
  post 'diagnostic_result_sacroiliac_joint', to: 'diagnostic_result#sacroiliac_joint'

  get 'diagnostic_result_intervertebral_disk', to: 'diagnostic_result#intervertebral_disk'
  post 'diagnostic_result_intervertebral_disk', to: 'diagnostic_result#intervertebral_disk'

  get 'diagnostic_result_incontestable', to: 'diagnostic_result#incontestable', as: 'diagnostic_result_incontestable'  # 追加

  # その他のルート
  get 'achlorhydria', to: 'diagnosis#achlorhydria'

end
