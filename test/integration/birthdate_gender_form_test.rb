require 'test_helper'

class BirthdateGenderFormTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(email: 'test@example.com', password: 'Password123')
    sign_in @user
  end

  test 'should submit valid birthdate and gender' do
    patch user_path(@user), params: { user: { birthdate: '1990-01-01', gender: 'male' } }
    assert_redirected_to profile_path(@user)
    follow_redirect!
    assert_select 'div.notice', 'Profile updated successfully.'
  end

  test 'should not allow future birthdate' do
    patch user_path(@user), params: { user: { birthdate: Date.tomorrow, gender: 'male' } }
    assert_response :unprocessable_entity
<<<<<<< HEAD
    assert_select 'div.alert', 'Birthdate can't be in the future'
=======
    assert_select 'div.alert', "Birthdate can't be in the future"
>>>>>>> d83ee46f6a74ffc7cff9ee3271ce5b3b2faeafbd
  end

  test 'should not allow missing gender' do
    patch user_path(@user), params: { user: { birthdate: '1990-01-01', gender: nil } }
    assert_response :unprocessable_entity
<<<<<<< HEAD
    assert_select 'div.alert', 'Gender can't be blank'
=======
    assert_select 'div.alert', "Gender can't be blank"
>>>>>>> d83ee46f6a74ffc7cff9ee3271ce5b3b2faeafbd
  end
end
