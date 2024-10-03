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

  post 'diagnosis', to: 'diagnosis#create'

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

  # 痛みの場所関連のルート
  get 'pain_location_flexion', to: 'pain_location_flexion#flexion'
  post 'submit_pain_location_flexion', to: 'pain_location_flexion#submit'

  # 椎間板関連
  get 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior', as: 'get_pain_behavior_flexion_intervertebral_disk_flexion_behavior'
  post 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior', as: 'pain_behavior_flexion_intervertebral_disk_flexion_behavior'
  get 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior', as: 'intervertebral_disk_flexion_behavior'


  # カウンターニューテーション関連
  get 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior', as: 'get_counternutation_flexion_behavior'
  post 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior', as: 'post_counternutation_flexion_behavior'
  get 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior', as: 'counternutation_flexion_behavior'
 
  # 筋膜性腰痛関連
  get 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior', as: 'myofascial_back_pain_flexion_behavior'
  post 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior'
 
  # 診断結果関連のルート
  get 'diagnostic_result/myofascial_back_pain', to: 'diagnostic_result#myofascial_back_pain', as: 'diagnostic_result_myofascial_back_pain'
  get 'diagnostic_result/intervertebral_disk', to: 'diagnostic_result#intervertebral_disk', as: 'diagnostic_result_intervertebral_disk'
  get 'diagnostic_result/counternutation', to: 'diagnostic_result#counternutation', as: 'diagnostic_result_counternutation'

  # その他のルート
  get 'achlorhydria', to: 'diagnosis#achlorhydria'
  get 'diagnostic_result/incontestable', to: 'diagnostic_result#incontestable', as: 'diagnostic_result_incontestable'

end
