Rails.application.routes.draw do
  # Devise のルーティング
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # ユーザー関連のルート
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
  get 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#counternutation_extention_flexion_behavior'

  # カウンターニューテーション関連
  get 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior'
  post 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior'

  # 診断結果関連
  get 'diagnostic_result/myofascial_back_pain', to: 'diagnostic_result#myofascial_back_pain'
  get 'diagnostic_result/intervertebral_disk', to: 'diagnostic_result#intervertebral_disk'
  get 'diagnostic_result/counternutation', to: 'diagnostic_result#counternutation'
  get 'diagnostic_result/incontestable', to: 'diagnostic_result#incontestable', as: 'diagnostic_result_incontestable'

  # その他のルート
  get 'terms', to: 'pages#terms'
  get 'diagnosis/achlorhydria', to: 'diagnosis#achlorhydria', as: 'diagnosis_achlorhydria'

  # 追加分
  get 'pain_location_extention_flexion/extention_flexion', to: 'pain_location_extention_flexion#extention_flexion'
  post 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/intervertebral_joint_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_joint_extention_flexion_behavior', as: 'pain_behavior_extention_flexion_intervertebral_joint_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/nutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#nutation_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/myofascial_back_pain_extention_behavior', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_behavior', as: 'pain_behavior_extention_flexion_myofascial_back_pain_extention_behavior'
  get 'pain_behavior_extention/myofascial_back_pain_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_flexion_behavior', as: 'pain_behavior_extention_myofascial_back_pain_extention_flexion_behavior'
  get 'pain_behavior_extention/intervertebral_joint_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_joint_extention_flexion_behavior', as: 'pain_behavior_extention_intervertebral_joint_extention_flexion_behavior'
  get 'pain_behavior_extention/nutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#nutation_extention_flexion_behavior', as: 'pain_behavior_extention_nutation_extention_flexion_behavior'
  get 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior'
  post 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior'
  get 'pain_behavior_flexion/intervertebral_joint_extention_behavior', to: 'pain_behavior_flexion#intervertebral_joint_extention_behavior'
  get 'users/all_form', to: 'users#all_form'
    get 'pain_behavior_flextion/myofascial_back_pain_flextion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flextion_behavior'
  get 'pain_behavior_extention/myofascial_back_pain_extention_behavior', to: 'pain_behavior_extention#myofascial_back_pain_extention_behavior'
  get 'pain_behavior_extention/intervertebral_disk_extention_behavior', to: 'pain_behavior_extention#intervertebral_disk_extention_behavior'
  get 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior', as: 'pain_behavior_flexion_intervertebral_disk_flexion_behavior'
  post 'pain_behavior_flexion/submit_pain_flexion', to: 'pain_behavior_flexion#submit_pain_flexion'
  get 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior', as: 'get_pain_behavior_flexion_intervertebral_disk'
  post 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior', as: 'submit_counternutation_flexion_behavior'
  post 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior', as: 'submit_myofascial_back_pain_flexion_behavior'
  post 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior', as: 'submit_intervertebral_disk_flexion_behavior'
  post 'pain_behavior_flexion/counternutation_flexion_behavior', to: 'pain_behavior_flexion#counternutation_flexion_behavior', as: 'submit_counternutation_flexion_behavior_v2'

  # 筋膜性腰痛ページの処理
  get 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_flexion_behavior', as: 'myofascial_back_pain_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#myofascial_back_pain_extention_flexion_behavior'
 post 'pain_behavior_extention/myofascial_back_pain_extention_behavior', to: 'pain_behavior_extention#myofascial_back_pain_extention_behavior', as: 'new_pain_behavior_extention_myofascial_back_pain_extention_behavior'
  get 'pain_behavior_extention/myofascial_back_pain_extention_behavior', to: 'pain_behavior_extention#myofascial_back_pain_extention_behavior', as: 'myofascial_back_pain_extention_behavior'
  post 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior', to: 'pain_behavior_flexion#myofascial_back_pain_flexion_behavior', as: 'myofascial_back_pain_flexion_behavior'

post 'pain_behavior_extention/myofascial_back_pain_extention_behavior', to: 'pain_behavior_extention#myofascial_back_pain_extention_behavior', as: 'create_pain_behavior_extention_myofascial_back_pain_extention_behavior'


  # 椎間関節の処理
  get 'pain_behavior_extention_flexion/intervertebral_joint_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_joint_extention_flexion_behavior', as: 'intervertebral_joint_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/intervertebral_joint_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_joint_extention_flexion_behavior'
  post 'pain_behavior_extention/intervertebral_joint_extention_behavior', to: 'pain_behavior_extention#intervertebral_joint_extention_behavior', as: 'pain_behavior_extention_intervertebral_joint_extention_behavior'
  
  


  # 椎間板ページの処理
  get 'pain_behavior_extention_flexion/intervertebral_disk_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_disk_extention_flexion_behavior', as: 'intervertebral_disk_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/intervertebral_disk_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#intervertebral_disk_extention_flexion_behavior'
  post 'pain_behavior_flexion/intervertebral_disk_flexion_behavior', to: 'pain_behavior_flexion#intervertebral_disk_flexion_behavior', as: 'post_pain_behavior_flexion_intervertebral_disk'



  # ニューテーションページの処理
  get 'pain_behavior_extention_flexion/nutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#nutation_extention_flexion_behavior', as: 'nutation_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/nutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#nutation_extention_flexion_behavior'
  post 'pain_behavior_extention/nutation_extention_behavior', to: 'pain_behavior_extention#nutation_extention_behavior', as: 'new_pain_behavior_extention_nutation_extention_behavior'
  get 'pain_behavior_extention/nutation_extention_behavior', to: 'pain_behavior_extention#nutation_extention_behavior'
  post 'pain_behavior_extention/nutation_extention_behavior', to: 'pain_behavior_extention#nutation_extention_behavior', as: 'nutation_extention_behavior'
  # カウンターニューテーションページの処理
  get 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#counternutation_extention_flexion_behavior', as: 'counternutation_extention_flexion_behavior'
  post 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior', to: 'pain_behavior_extention_flexion#counternutation_extention_flexion_behavior'

  #app/controllers/pain_behavior_extention_controller.rb
  # 筋膜性腰痛ページの処理
  get 'pain_behavior_extention/myofascial_back_pain_extention_behavior', to: 'pain_behavior_extention#myofascial_back_pain_extention_behavior', as: 'new_myofascial_back_pain_extention_behavior'
  
  # 椎間関節の処理
  get 'pain_behavior_extention/intervertebral_joint_extention_behavior', to: 'pain_behavior_extention#intervertebral_joint_extention_behavior', as: 'new_intervertebral_joint_extention_behavior'
  post 'pain_behavior_extention/intervertebral_joint_extention_behavior', to: 'pain_behavior_extention#intervertebral_joint_extention_behavior'
  get 'diagnostic_result/intervertebral_joint', to: 'diagnostic_result#intervertebral_joint', as: 'diagnostic_result_intervertebral_joint'
  # ニューテーションページの処理
  get 'pain_behavior_extention/nutation_extention_behavior', to: 'pain_behavior_extention#nutation_extention_behavior', as: 'new_nutation_extention_behavior'


  #app/controllers/pain_behavior_extention_controller.rb
  get 'pain_location_extention_flexion', to: 'pain_location_extention_flexion#extention_flexion', as: 'pain_location_extention_flexion'
end

