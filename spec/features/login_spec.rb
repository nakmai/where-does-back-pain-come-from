require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  let!(:user) { User.create(email: 'test@example.com', password: 'Password123') }

  it '間違った情報でエラーメッセージが表示されるかどうか' do
    visit new_user_session_path
    fill_in 'user[email]', with: 'test2@example.com' # フィールド名修正
    fill_in 'user[password]', with: 'wrongpassword' # フィールド名修正
    click_button 'ログイン'
    expect(page).to have_content('無効なメールアドレスまたはパスワードです。')
  end
end
