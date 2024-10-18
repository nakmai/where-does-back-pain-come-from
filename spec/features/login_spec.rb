require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  let!(:account) { Account.create(email: 'test@example.com', password: 'Password123') }

  it '正しい情報でログインできるかどうか' do
    visit login_path
    fill_in 'Eメール', with: 'test@example.com'
    fill_in 'パスワード', with: 'Password123'
    click_button 'ログイン'
    expect(page).to have_content 'ログイン成功'
  end

  it '間違った情報でエラーメッセージが表示されるかどうか' do
    visit login_path
    fill_in 'Eメール', with: 'test@example.com'
    fill_in 'パスワード', with: 'wrongpassword'
    click_button 'ログイン'
    expect(page).to have_content 'ログインに失敗しました'
  end
end

