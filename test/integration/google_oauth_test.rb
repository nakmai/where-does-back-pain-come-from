require "test_helper"

class GoogleOauthTest < ActionDispatch::IntegrationTest
  setup do
    # Omniauthのモック設定
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123545',
      info: {
        email: 'test@google.com'
      },
      credentials: {
        token: 'mock_token',
        refresh_token: 'mock_refresh_token',
        expires_at: Time.now + 1.week
      },
      extra: {
        raw_info: {
          birthday: '1990-01-01',
          gender: 'male'
        }
      }
    })
  end

  test "should create user from google oauth with valid birthdate and gender" do
    assert_difference('User.count', 1) do
      get user_google_oauth2_omniauth_callback_url
    end

    user = User.last
    assert_equal 'test@google.com', user.email
    assert_equal '1990-01-01', user.birthdate.to_s
    assert_equal 'male', user.gender
  end

  test "should create user from google oauth without birthdate and gender" do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123545',
      info: {
        email: 'test@google.com'
      },
      credentials: {
        token: 'mock_token',
        refresh_token: 'mock_refresh_token',
        expires_at: Time.now + 1.week
      },
      extra: {
        raw_info: {
          birthday: nil,
          gender: nil
        }
      }
    })

    assert_difference('User.count', 1) do
      get user_google_oauth2_omniauth_callback_url
    end

    user = User.last
    assert_equal 'test@google.com', user.email
    assert_nil user.birthdate
    assert_nil user.gender
  end
end

