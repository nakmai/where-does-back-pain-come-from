Rails.application.routes.draw do
  get 'static_pages/terms'
  get 'static_pages/privacy_policy'
  get 'my/page'

  # Devise のルーティング
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    post 'users/sign_up', to: 'users/registrations#create', as: 'custom_user_registration'
    get 'users/password/new', to: 'devise/passwords#new'
    post 'users/password', to: 'devise/passwords#create'
    get 'users/password/edit', to: 'devise/passwords#edit'
    put 'users/password', to: 'devise/passwords#update'
    delete 'users', to: 'users/registrations#destroy', as: 'delete_user_registration'
  end

  # ゲストページ
  get 'guest/counternutation', to: 'users/guest#counternutation', as: :guest_counternutation
  get 'guest/intervertebral_disk', to: 'users/guest#intervertebral_disk', as: :guest_intervertebral_disk
  get 'guest/intervertebral_joint', to: 'users/guest#intervertebral_joint', as: :guest_intervertebral_joint
  get 'guest/myofascial_back_pain', to: 'users/guest#myofascial_back_pain', as: :guest_myofascial_back_pain
  get 'guest/nutation', to: 'users/guest#nutation', as: :guest_nutation

  # ユーザーページ
  get 'user/counternutation', to: 'users#counternutation', as: :user_counternutation
  get 'user/intervertebral_disk', to: 'users#intervertebral_disk', as: :user_intervertebral_disk
  get 'user/intervertebral_joint', to: 'users#intervertebral_joint', as: :user_intervertebral_joint
  get 'user/myofascial_back_pain', to: 'users#myofascial_back_pain', as: :user_myofascial_back_pain
  get 'user/nutation', to: 'users#nutation', as: :user_nutation

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
      get 'my_page'
      get 'myofascial_back_pain/:pain_id', to: 'users#myofascial_back_pain', as: 'myofascial_back_pain'
      get 'nutation/:pain_id', to: 'users#nutation', as: 'nutation'
      get 'counternutation/:pain_id', to: 'users#counternutation', as: 'counternutation'
      get 'intervertebral_disk/:pain_id', to: 'users#intervertebral_disk', as: 'intervertebral_disk'
      get 'intervertebral_joint/:pain_id', to: 'users#intervertebral_joint', as: 'intervertebral_joint'
    end
  end

  post 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior',
       to: 'pain_behavior_extention_flexion#counternutation_extention_flexion_behavior', as: 'pain_behavior_extention_flexion_counternutation_extention_flexion_behavior'
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

  # profile
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
<<<<<<< HEAD
  get 'red_flag3', to: 'pain#red_flag3'
post 'red_flag3_submit', to: 'pain#red_flag3_submit', as: 'red_flag3_submit'
=======
>>>>>>> d83ee46f6a74ffc7cff9ee3271ce5b3b2faeafbd

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
  post 'terms', to: 'pages#terms'
  get 'diagnosis/achlorhydria', to: 'diagnosis#achlorhydria', as: 'diagnosis_achlorhydria'
  get 'users/all_form', to: 'users#all_form', as: 'users_all_form'

  # 追加分
  delete 'myofascial_back_pain_guest', to: 'my_page#destroy_myofascial_back_pain_guest', as: 'my_page_destroy_myofascial_back_pain_guest'
  get '/oauth2callback', to: 'oauth#callback'
  get 'check_user_data', to: 'users#check_user_data'
  get 'guest_intervertebral_joint', to: 'my_page#intervertebral_joint_guest', as: 'guest_intervertebral_joint_page'
  get 'intervertebral_joint_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_joint_extention_flexion_behavior'
  get 'my_page_counternutation_guest', to: 'users#counternutation_guest', as: 'my_page_counternutation_guest_user'
  get 'new_guest_intervertebral_joint', to: 'my_page#new_guest_intervertebral_joint', as: 'new_guest_intervertebral_joint_page'
  get 'new_guest_intervertebral_joint', to: 'users#guest_page', as: 'guest_intervertebral_joint_path'
  get 'pain_behavior_extention/unknown_extention_behavior', to: 'pain_behavior_extention#unknown_extention_behavior'
  get 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_flexion_behavior'
  get 'pain_behavior_extention_flexion/unknown_extention_behavior_flexion', to: 'pain_behavior_extention_flexion#unknown_extention_behavior_flexion'
  get 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior'
  get 'pain_behavior_flexion/unknown_flexion_behavior', to: 'pain_behavior_flexion#unknown_flexion_behavior'
  get 'pain_location_extention_flexion', to: 'pain_location_extention_flexion#extention_flexion', as: 'pain_location_extention_flexion'
  get 'pain_location_extention_flexion/extention_flexion', to: 'pain_location_extention_flexion#extention_flexion'
  get 'users/:id/intervertebral_joint', to: 'my_page#intervertebral_joint_user', as: 'my_page_intervertebral_joint_user'
  get 'users/:id/myofascial_back_pain/:user_id', to: 'my_page#myofascial_back_pain_user', as: 'my_page_myofascial_back_pain_user'
  get 'users/:id/profile_page', to: 'users#profile_page', as: 'user_profile_page'
  post 'counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior'
<<<<<<< HEAD
  post 'pain_behavior_extention/counternutation_extention_behavior', to: 'pain_behavior_extention#counternutation_extention_behavior',
                                                                     as: 'pain_behavior_extention_counternutation_extention_behavior'
=======
  post 'pain_behavior_extention/counternutation_extention_behavior', to: 'pain_behavior_extention#counternutation_extention_behavior', as: 'pain_behavior_extention_counternutation_extention_behavior'
>>>>>>> d83ee46f6a74ffc7cff9ee3271ce5b3b2faeafbd
  post 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#counternutation_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/intervertebral_disk_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_disk_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/intervertebral_joint_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_joint_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/nutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#nutation_extention_flexion_behavior', as: 'nutation_extention_flexion_behavior'
  post 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior'
  post 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior'
  post 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior', as: 'submit_intervertebral_disk_flexion_behavior'
  post 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior'
  post 'pain_behavior_flexion/nutation_flexion_behavior', to: 'pain_behavior_flexion#nutation_flexion_behavior', as: 'nutation_flexion_behavior'
<<<<<<< HEAD
  post 'pain_behavior_extention/intervertebral_joint_extention_behavior', to: 'pain_behavior_extention#intervertebral_joint_extention_behavior',
                                                                          as: 'pain_behavior_extention_intervertebral_joint_extention_behavior'
=======
  post 'pain_behavior_extention/intervertebral_joint_extention_behavior', to: 'pain_behavior_extention#intervertebral_joint_extention_behavior', as: 'pain_behavior_extention_intervertebral_joint_extention_behavior'
>>>>>>> d83ee46f6a74ffc7cff9ee3271ce5b3b2faeafbd
  post 'submit_pain_location_flexion', to: 'pain_location_flexion#submit', as: 'submit_pain_location_flexion_v2'
  post 'submit_pain_location_extention_flexion', to: 'pain_location_extention_flexion#submit'
  post 'users/add_bookmark', to: 'users#add_bookmark', as: 'add_bookmark'

  # Stretch Routes
  get 'stretch/adductor', to: 'stretch#adductor', as: :stretch_adductor
  get 'stretch/gluteus_maximus', to: 'stretch#gluteus_maximus', as: :stretch_gluteus_maximus
  get 'stretch/hamstrings_towel', to: 'stretch#hamstrings_towel', as: :stretch_hamstrings_towel
  get 'stretch/hamstrings', to: 'stretch#hamstrings', as: :stretch_hamstrings
  get 'stretch/psoas', to: 'stretch#psoas', as: :stretch_psoas
  get 'stretch/quadriceps_femoris', to: 'stretch#quadriceps_femoris', as: :stretch_quadriceps_femoris
  get 'stretch/top', to: 'stretch#top', as: :stretch_top

  # Muscle Routes
  get 'muscle/adductor', to: 'muscle#adductor', as: :muscle_adductor
  get 'muscle/erector_spinae', to: 'muscle#erector_spinae', as: :muscle_erector_spinae
  get 'muscle/gluteus_maximus', to: 'muscle#gluteus_maximus', as: :muscle_gluteus_maximus
  get 'muscle/hamstrings', to: 'muscle#hamstrings', as: :muscle_hamstrings
  get 'muscle/polysaccharidic', to: 'muscle#polysaccharidic', as: :muscle_polysaccharidic
  get 'muscle/psoas', to: 'muscle#psoas', as: :muscle_psoas
  get 'muscle/quadriceps_femoris', to: 'muscle#quadriceps_femoris', as: :muscle_quadriceps_femoris
  get 'muscle/rectus_abdominis', to: 'muscle#rectus_abdominis', as: :muscle_rectus_abdominis
  get 'muscle/transversus_abdominis', to: 'muscle#transversus_abdominis', as: :muscle_transversus_abdominis
  get 'muscle/top', to: 'muscle#top', as: 'muscle_top'

  # Rehabilitation Routes
  get 'rehabilitation/back_twist', to: 'rehabilitation#back_twist', as: :rehabilitation_back_twist
  get 'rehabilitation/cat_and_dog', to: 'rehabilitation#cat_and_dog', as: :rehabilitation_cat_and_dog
  get 'rehabilitation/cramshell', to: 'rehabilitation#cramshell', as: :rehabilitation_cramshell
  get 'rehabilitation/draw_in', to: 'rehabilitation#draw_in', as: :rehabilitation_draw_in
  get 'rehabilitation/hand_knee', to: 'rehabilitation#hand_knee', as: :rehabilitation_hand_knee
  get 'rehabilitation/hiplift', to: 'rehabilitation#hiplift', as: :rehabilitation_hiplift
  get 'rehabilitation/slr', to: 'rehabilitation#slr', as: :rehabilitation_slr
  get 'rehabilitation/top', to: 'rehabilitation#top', as: :rehabilitation_top
  get 'rehabilitation/yurikago', to: 'rehabilitation#yurikago', as: :rehabilitation_yurikago

  # 利用規約ページへのルート
  get 'terms_of_use', to: 'pages#terms_of_use', as: 'terms_of_use'

  # プライバシーポリシーページへのルート
  get 'privacy', to: 'pages#privacy', as: 'privacy'

  resources :users, only: [:show] do
    member do
      delete 'remove_bookmark', to: 'users#remove_bookmark'
      delete 'remove_all_bookmarks', to: 'users#remove_all_bookmarks'
    end
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> d83ee46f6a74ffc7cff9ee3271ce5b3b2faeafbd
