require 'test_helper'

# test/controllers/static_pages_controller_test.rb
class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # fixtures からユーザーを読み込む
    sign_in @user       # ユーザーをログイン
  end

  test 'should get terms' do
    get static_pages_terms_url
    assert_response :success
  end
end
