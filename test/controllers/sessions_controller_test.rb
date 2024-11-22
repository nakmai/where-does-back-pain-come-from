require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # ユーザーフィクスチャなどを使用
    sign_in @user       # ユーザーをサインイン
  end

  test 'should log in with valid credentials' do
    post user_session_url, params: { user: { email: @user.email, password: 'Password123' } }
    assert_response :redirect
  end

  test 'should not log in with invalid credentials' do
    post user_session_url, params: { user: { email: @user.email, password: 'wrongpassword' } }
    assert_response :unprocessable_entity
  end

  test 'should log in with google' do
    get user_google_oauth2_omniauth_callback_url
    assert_redirected_to root_url
  end
end
