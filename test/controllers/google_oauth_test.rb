require 'test_helper'

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                     provider: 'google_oauth2',
                                                                     uid: '123456789',
                                                                     info: {
                                                                       email: 'test@google.com'
                                                                     },
                                                                     extra: {
                                                                       raw_info: {
                                                                         birthday: '1990-01-01',
                                                                         gender: 'male'
                                                                       }
                                                                     }
                                                                   })

class Users::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test 'should create user from google oauth' do
    assert_difference('User.count', 1) do
      get user_google_oauth2_omniauth_callback_url
    end

    user = User.last
    assert_equal 'test@google.com', user.email
    assert_equal '1990-01-01', user.birthdate.to_s
    assert_equal 'male', user.gender
  end

  test 'should log in existing user via google oauth' do
    user = users(:one) # Googleアカウントで作成された既存のユーザー
    get user_google_oauth2_omniauth_callback_url
    assert_equal session[:user_id], user.id
  end
end
