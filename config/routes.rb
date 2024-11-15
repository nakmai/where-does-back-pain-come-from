Rails.application.routes.draw do
  # Static Pages
  get 'static_pages/terms'
  get 'static_pages/privacy_policy'

  # Devise Routes
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

  # Guest Pages
  namespace :guest do
    get 'counternutation'
    get 'intervertebral_disk'
    get 'intervertebral_joint'
    get 'myofascial_back_pain'
    get 'nutation'
  end

  # User Pages
  resources :users, only: [:show, :create] do
    collection do
      post 'submit_form'
      get 'all_form'
    end
    member do
      post 'my_page_register'
      get 'my_page'
    end
  end
  get 'users/:id/profile_page', to: 'users#profile_page', as: 'user_profile_page'

  # Stretch Routes
  namespace :stretch do
    get 'adductor'
    get 'gluteus_maximus'
    get 'hamstrings_towel'
    get 'hamstrings'
    get 'psoas'
    get 'quadriceps_femoris'
  end

  # Muscle Routes
  namespace :muscle do
    get 'adductor'
    get 'gluteus_maximus'
    get 'hamstrings'
    get 'polysaccharidic'
    get 'psoas'
    get 'quadriceps_femoris'
    get 'transversus_abdominis'
  end

  # Rehabilitation Routes
  namespace :rehabilitation do
    get 'back_twist'
    get 'cat_and_dog'
    get 'cramshell'
    get 'draw_in'
    get 'hand_knee'
    get 'hiplift'
    get 'slr'
    get 'top'
    get 'yurikago'
  end

  # Pain and Diagnosis Routes
  resources :pain, only: [] do
    collection do
      get 'scale'
      post 'submit_pain_scale'
      get 'red_flag'
      post 'submit_red_flag'
      get 'red_flag2'
      post 'red_flag2_submit'
    end
  end

  # Orthopedics Routes
  namespace :orthopedics do
    get 'advice1'
    get 'advice2'
    get 'advice3'
    get 'advice5'
    get 'advice6'
  end

  # Gynecology Routes
  namespace :gynecology do
    get 'question'
    post 'submit_question'
    post 'check'
    get 'advice'
  end

  # Diagnosis Results
  namespace :diagnostic_result do
    get 'myofascial_back_pain'
    get 'intervertebral_disk'
    get 'intervertebral_joint'
    get 'counternutation'
    get 'incontestable'
  end

  # Miscellaneous Routes
  get 'terms', to: 'pages#terms'
  post 'terms', to: 'pages#terms'
  get 'terms_of_use', to: 'pages#terms_of_use', as: 'terms_of_use'
  get 'privacy', to: 'pages#privacy', as: 'privacy'
  root 'home#index'
  get 'home/index'
  get 'after_sign_in', to: 'home#after_sign_in'
  get 'logout_complete', to: 'home#logout_complete'
end
