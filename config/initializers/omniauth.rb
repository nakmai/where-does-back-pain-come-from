Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
      scope: 'email,profile',
      prompt: 'select_account',
      provider_ignores_state: false # CSRF保護を有効にする
    }
  end
  
  OmniAuth.config.allowed_request_methods = [:post]
  
  

  