require "test_helper"

class BookmarksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one) # フィクスチャからポストデータを取得
    sign_in @user # Deviseのログインヘルパーを使用
  end

  # ブックマーク作成テスト
  test "should create bookmark" do
    post bookmarks_url, params: { bookmark: { url: 'http://example.com' } }
    assert_response :success
  end

  # ブックマーク全削除テスト
  test "should destroy all bookmarks" do
    Bookmark.create(user: @user, post: @post)
    assert_difference('Bookmark.count', -1) do
      delete delete_all_bookmarks_url
    end
    assert_redirected_to bookmarks_url
  end

  # ブックマーク削除テスト
  test "should destroy bookmark" do
    assert_difference('Bookmark.count', -1) do
      delete bookmark_url(@bookmark)
    end
    assert_redirected_to bookmarks_url
  end
end


