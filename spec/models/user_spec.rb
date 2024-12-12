# frozen_string_literal: true

# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context 'when creating a user' do
    it 'is valid with valid birthdate, gender, and email' do
      user = User.new(email: 'test@example.com', password: 'Password123', birthdate: '1990-01-01', gender: 'male')
      expect(user).to be_valid
    end

    it 'is invalid with future birthdate' do
      user = User.new(email: 'test@example.com', password: 'Password123', birthdate: Date.tomorrow, gender: 'male')
      user.valid? # バリデーションをトリガー
      expect(user).to_not be_valid
      expect(user.errors[:birthdate]).to include('未来の日付は無効です')
    end

    it 'is invalid without gender' do
      user = User.new(email: 'test@example.com', password: 'Password123', birthdate: '1990-01-01', gender: nil)
      user.valid? # バリデーションをトリガー
      expect(user).to_not be_valid
      expect(user.errors[:gender]).to include('性別を選んでください') # カスタムメッセージに修正
    end

    it 'is invalid with duplicate email' do
      existing_user = create(:user, email: 'test@example.com')
      user = User.new(email: existing_user.email, password: 'Password123', birthdate: '1990-01-01', gender: 'male')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('このメールアドレスは既に登録されています')
    end

    it 'is invalid with short password' do
      user = User.new(email: 'test@example.com', password: 'short', birthdate: '1990-01-01', gender: 'male')
      user.valid? # バリデーションをトリガー
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('パスワードは6文字以上〜20文字以内大文字・小文字・数字が必要です')
    end
  end

  context '生年月日' do
    it '未来の日付は無効かどうか' do
      user.birthdate = Date.tomorrow
      user.valid?
      expect(user.errors[:birthdate]).to include('未来の日付は無効です')
    end

    it '有効な生年月日が保存できるかどうか' do
      user.birthdate = Date.new(1990, 1, 1)
      expect(user.save).to be_truthy
    end
  end

  context '性別' do
    it '性別が保存できるかどうか' do
      user.gender = 'male'
      expect(user.save).to be_truthy
    end

    it '性別が未入力の場合にエラーを出すかどうか' do
      user.gender = nil
      user.valid? # バリデーションをトリガー
      expect(user.errors[:gender]).to include('性別を選んでください') # カスタムメッセージに修正
    end
  end

  # ここからブックマーク機能のテスト
  context 'ブックマーク機能' do
    let(:url) { 'https://example.com' }
    let(:name) { 'Example' }

    it 'ブックマークが追加できるかどうか' do
      user.add_bookmark(url: url, name: name)
      expect(user.registered_pages).to include({ name: name, url: url })
    end

    it 'ブックマークが削除できるかどうか' do
      user.add_bookmark(url: url, name: name)
      user.remove_bookmark(url)
      expect(user.registered_pages).to_not include({ name: name, url: url })
    end

    it 'すべてのブックマークを削除できるかどうか' do
      user.add_bookmark(url: 'https://example1.com', name: 'Example1')
      user.add_bookmark(url: 'https://example2.com', name: 'Example2')

      user.registered_pages.clear
      expect(user.registered_pages).to be_empty
    end
  end
end
