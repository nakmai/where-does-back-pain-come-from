require 'test_helper'

class MyControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # fixtures から適切なユーザーを取得
    sign_in @user       # ユーザーをログイン
  end

  test 'should get page' do
    get my_page_url
    assert_response :success
  end
end
