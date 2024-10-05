require "test_helper"

class MyControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get my_page_url
    assert_response :success
  end
end
