Rails.application.routes.draw do
  get 'my/page'
  # Devise のルーティング
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/sign_up', to: 'users/registrations#create', as: 'custom_user_registration'
  end

  # ユーザー関連のルート
  resources :users, only: [:create] do
    collection do
      post 'submit_form'
    end
  end

  resources :users, only: [] do
    collection do
      get 'all_form', to: 'users#all_form'
    end
  end

  resources :users do
    member do
      post 'my_page_register', to: 'users#my_page_register'
      get 'profile_page'
      post 'my_page' 
    end
  end
      post 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#counternutation_extention_flexion_behavior', as: 'pain_behavior_extention_flexion_counternutation_extention_flexion_behavior'
      post 'my_page_counternutation', to: 'users#my_page_counternutation'
      post 'copy_counternutation', to: 'users#copy_counternutation'
      get 'my_page_counternutation_user', to: 'users#counternutation_user', as: 'my_page_counternutation_user'
      post 'my_page/copy_intervertebral_disk', to: 'my_page#copy_intervertebral_disk', as: 'copy_intervertebral_disk'
      get 'my_page_intervertebral_disk_user', to: 'users#intervertebral_disk_user', as: 'my_page_intervertebral_disk_user'
      get 'my_page_intervertebral_disk_guest', to: 'users#intervertebral_disk_guest', as: 'my_page_intervertebral_disk_guest'
      get 'intervertebral_joint', to: 'my_page#intervertebral_joint'
      get 'my_page_intervertebral_joint_guest', to: 'users#intervertebral_joint_guest', as: 'my_page_intervertebral_joint_guest'
   
      get 'my_page_nutation_user', to: 'users#nutation_user', as: 'my_page_nutation_user'
      get 'my_page_nutation_guest', to: 'users#nutation_guest', as: 'my_page_nutation_guest'


  
  # flexion_behavior
  get 'guest_myofascial_back_pain_flexion', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior'
  get 'guest_intervertebral_disk_flexion', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior'
  get 'guest_counternutation_flexion', to: 'pain_behavior_flexion#counternutation_flexion_behavior'
  get 'nutation_guest', to: 'pain_behavior_flexion#rnutation_flexion_behavior'
  get 'guest_counternutation_flexion', to: 'pain_behavior_flexion#counternutation_flexion_behavior'
  

  # extention_behavior
  get 'guest_myofascial_back_pain_extention', to: 'pain_behavior_extention#myofascial_back_pain_extention_behavior'
  get 'guest_intervertebral_joint', to: 'pain_behavior_extention#intervertebral_joint_extention_behavior'
  get 'guest_nutation_extention', to: 'pain_behavior_extention#nutation_extention_behavior'
  get 'intervertebral_joint_guest', to: 'pain_behavior_extention#intervertebral_joint_guest'
  get 'guest_counternutation_extention', to: 'pain_behavior_extention_flexion#counternutation_extention_behavior'
  
  # extention_flexion_behavior
  get 'guest_myofascial_back_pain_extention_flexion', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_flexion_behavior'
  
  get 'guest_intervertebral_disk_extention_flexion', to: 'pain_behavior_extention_flexion#intervertebral_disk_extention_flexion_behavior'
  get 'guest_nutation_extention_flexion', to: 'pain_behavior_extention_flexion#nutation_extention_flexion_behavior'
  get 'guest_counternutation_extention_flexion', to: 'pain_behavior_extention_flexion#counternutation_extention_flexion_behavior'

  #purofile
  get 'users/profile_page', to: 'users#profile_page', as: 'users_profile_page'

  # ホームページとログイン後のページ
  root 'home#index'
  get 'home/index' 
  get 'after_sign_in', to: 'home#after_sign_in'
  get 'logout_complete', to: 'home#logout_complete'
 

  # 診断関連
  post 'diagnosis', to: 'diagnosis#create'

  # ペインスケール関連
  get 'pain_scale', to: 'pain#pain_scale'
  post 'pain/submit_pain_scale', to: 'pain#submit_pain_scale'

  # レッドフラッグ関連
  get 'red_flag', to: 'pain#red_flag'
  post 'red_flag', to: 'pain#submit_red_flag'
  get 'red_flag2', to: 'pain#red_flag2'
  post 'red_flag2_submit', to: 'pain#red_flag2_submit'

  # 整形外科関連
  get 'orthopedics_advice1', to: 'orthopedics#orthopedics_advice1'
  get 'orthopedics_advice2', to: 'orthopedics#orthopedics_advice2'
  get 'orthopedics_advice3', to: 'orthopedics#orthopedics_advice3'
  get 'orthopedics_advice5', to: 'orthopedics#orthopedics_advice5'
  get 'orthopedics_advice6', to: 'orthopedics#orthopedics_advice6'

  # 婦人科関連
  get 'gynecology_question', to: 'gynecology#gynecology_question'
  post 'submit_gynecology_question', to: 'gynecology#submit_gynecology_question'
  post 'gynecology/check', to: 'gynecology#check', as: 'gynecology_check'
  get 'gynecology_advice', to: 'gynecology#gynecology_advice'
  
  # achlorhydria のルートを追加
  get 'achlorhydria', to: 'diagnosis#achlorhydria', as: 'achlorhydria'

  # 痛みの場所関連のルート
  get 'pain_location_flexion', to: 'pain_location_flexion#flexion'
  post 'submit_pain_location_flexion', to: 'pain_location_flexion#submit'
  get 'pain_location_extention', to: 'pain_location_extention#extention', as: 'pain_location_extention'
  post 'pain_location_extention/submit', to: 'pain_location_extention#submit', as: 'submit_pain_location_extention'

  # pain_behavior_extention に関するルート
  post 'pain_behavior_extention/intervertebral_disk_extention_behavior', to: 'pain_behavior_extention#intervertebral_disk_extention_behavior'
  post 'pain_behavior_extention/myofascial_back_pain_extention_behavior', to: 'pain_behavior_extention#myofascial_back_pain_extention_behavior'
  post 'pain_behavior_extention/nutation_extention_behavior', to: 'pain_behavior_extention#nutation_extention_behavior'

  # pain_behavior_extention_flexion に関するルート
  post 'submit_pain_location_extention_flexion', to: 'pain_location_extention_flexion#submit'
  
  
  # カウンターニューテーション関連
  get 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior'
  post 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior'

  # 診断結果関連
  get 'diagnostic_result/myofascial_back_pain', to: 'diagnostic_result#myofascial_back_pain'
  get 'diagnostic_result/intervertebral_disk', to: 'diagnostic_result#intervertebral_disk'
  get 'diagnostic_result/intervertebral_joint', to: 'diagnostic_result#intervertebral_joint'
  get 'diagnostic_result/counternutation', to: 'diagnostic_result#counternutation'
  get 'diagnostic_result/incontestable', to: 'diagnostic_result#incontestable', as: 'diagnostic_result_incontestable'

  # その他のルート
  get 'terms', to: 'pages#terms'
  get 'diagnosis/achlorhydria', to: 'diagnosis#achlorhydria', as: 'diagnosis_achlorhydria'
  get 'users/all_form', to: 'users#all_form', as: 'users_all_form'



  # 追加分
  get 'pain_location_extention_flexion/extention_flexion', to: 'pain_location_extention_flexion#extention_flexion'
  post 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior', as: 'submit_intervertebral_disk_flexion_behavior'
  post 'counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior'
  post 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior'
  post 'pain_behavior_flexion/nutation_flexion_behavior', to: 'pain_behavior_flexion#nutation_flexion_behavior', as: 'nutation_flexion_behavior'
  get 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior'
  post 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior'
  post 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior'
  post 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior'
  post 'submit_pain_location_flexion', to: 'pain_location_flexion#submit', as: 'submit_pain_location_flexion_v2'
  post 'pain_behavior_extention/intervertebral_joint_extention_behavior', to: 'pain_behavior_extention#intervertebral_joint_extention_behavior', as: 'pain_behavior_extention_intervertebral_joint_extention_behavior'
  
  get 'pain_location_extention_flexion', to: 'pain_location_extention_flexion#extention_flexion', as: 'pain_location_extention_flexion'
  post 'pain_behavior_extention/counternutation_extention_behavior', to: 'pain_behavior_extention#counternutation_extention_behavior', as: 'pain_behavior_extention_counternutation_extention_behavior'

  post 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/intervertebral_joint_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_joint_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/intervertebral_disk_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_disk_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/nutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#nutation_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#counternutation_extention_flexion_behavior'
  get 'intervertebral_joint_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_joint_extention_flexion_behavior'
 get 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_flexion_behavior'
 delete 'myofascial_back_pain_guest', to: 'my_page#destroy_myofascial_back_pain_guest', as: 'my_page_destroy_myofascial_back_pain_guest'
get 'guest_myofascial_back_pain', to: 'my_page#myofascial_back_pain_guest', as: 'guest_myofascial_back_pain'
get 'guest_intervertebral_disk', to: 'my_page#intervertebral_disk_guest', as: 'guest_intervertebral_disk'

get 'my_page_counternutation_guest', to: 'users#counternutation_guest', as: 'my_page_counternutation_guest_user'
get 'guest_intervertebral_joint', to: 'my_page#intervertebral_joint_guest', as: 'guest_intervertebral_joint_page'


get 'users/:id/myofascial_back_pain/:user_id', to: 'my_page#myofascial_back_pain_user', as: 'my_page_myofascial_back_pain_user'

  get 'users/:id/intervertebral_joint', to: 'my_page#intervertebral_joint_user', as: 'my_page_intervertebral_joint_user'
  post 'pain_behavior_extention_flexion/nutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#nutation_extention_flexion_behavior', as: 'nutation_extention_flexion_behavior'
  get 'new_guest_intervertebral_joint', to: 'my_page#new_guest_intervertebral_joint', as: 'new_guest_intervertebral_joint_page'
get 'pain_behavior_extention/intervertebral_joint_extention_behavior', to: 'my_page#intervertebral_joint_user', as: 'intervertebral_joint_extention_behavior'

post 'users/add_bookmark', to: 'users#add_bookmark', as: 'add_bookmark'





get 'users/:id/profile_page', to: 'users#profile_page', as: 'user_profile_page'
resources :users, only: [:show] do
  member do
    delete 'remove_bookmark', to: 'users#remove_bookmark'
    delete 'remove_all_bookmarks', to: 'users#remove_all_bookmarks'  # 全て削除
  end
end
end