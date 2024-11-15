require "test_helper"

class UserTest < ActiveSupport::TestCase
  # 生年月日が入力できるか
  test "should save user with valid birthdate" do
    user = User.new(email: "test@example.com", password: "Password123", birthdate: "1990-01-01", gender: "male")
    assert user.save
  end

  # 未来の生年月日は弾くか
  test "should not save user with future birthdate" do
    user = users(:one)
    user.birthdate = Date.tomorrow
    assert_includes user.errors[:birthdate], "未来の日付は無効です"
  end

  # 性別がチェックできるか
  test "should save user with valid gender" do
    user = users(:one)
    user.gender = nil
    assert user.save
  end

  # 性別にチェックがない場合のエラー
  test "should not save user without gender" do
    user = User.new(email: "test@example.com", password: "Password123", birthdate: "1990-01-01", gender: nil)
    assert_not user.save
    assert_includes user.errors[:gender], "can't be blank"
  end

  # Eメールがすでに登録されている場合のエラー
  test "should not save user with duplicate email" do
    existing_user = users(:one)
    user = User.new(email: existing_user.email, password: "Password123", birthdate: "1990-01-01", gender: "male")
    assert_not user.save
    assert_includes user.errors[:email], "このメールアドレスは既に登録されています"
  end

  # パスワードの長さと複雑性のテスト
  test "should not save user with invalid password" do
    user = User.new(email: "test@example.com", password: "short", birthdate: "1990-01-01", gender: "male")
    assert_not user.save
    assert_includes user.errors[:password]
  end

  test "should save user with valid password" do
    user = User.new(email: "test@example.com", password: "Password123", birthdate: "1990-01-01", gender: "male")
    assert user.save
  end
end



