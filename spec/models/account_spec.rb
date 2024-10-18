require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:valid_email) { "test@example.com" }
  let(:valid_password) { "Password123" }
  let(:valid_birthday) { Date.new(1990, 1, 1) }

  context '生年月日' do
    it '生年月日が入力できるかどうか' do
      account = Account.new(birthday: valid_birthday)
      expect(account.birthday).to eq(valid_birthday)
    end

    it '未来の生年月日は無効であること' do
      future_date = Date.today + 1.year
      account = Account.new(birthday: future_date)
      expect(account.valid?).to be_falsey
      expect(account.errors[:birthday]).to include("can't be in the future")
    end
  end

  context '性別' do
    it '性別がチェックできるかどうか' do
      account = Account.new(gender: "male")
      expect(account.gender).to eq("male")
    end

    it '性別がチェックされていない場合、エラーメッセージが出るかどうか' do
      account = Account.new(gender: nil)
      expect(account.valid?).to be_falsey
      expect(account.errors[:gender]).to include("can't be blank")
    end
  end

  context 'Eメール' do
    it 'Eメールが入力できるかどうか' do
      account = Account.new(email: valid_email)
      expect(account.email).to eq(valid_email)
    end

    it 'Eメールがすでに作成されている場合、エラーメッセージが出るかどうか' do
      existing_account = Account.create(email: valid_email)
      account = Account.new(email: valid_email)
      expect(account.valid?).to be_falsey
      expect(account.errors[:email]).to include("has already been taken")
    end
  end

  context 'パスワード' do
    it 'パスワードが入力できるかどうか' do
      account = Account.new(password: valid_password)
      expect(account.password).to eq(valid_password)
    end

    it 'パスワードが6文字以上〜20文字以内で、小文字・大文字・数字を含むかどうか' do
      account = Account.new(password: valid_password)
      expect(account.valid?).to be_truthy
    end

    it '不正なパスワードは無効であること' do
      invalid_password = "pass"  # 6文字未満、条件を満たさない
      account = Account.new(password: invalid_password)
      expect(account.valid?).to be_falsey
      expect(account.errors[:password]).to include("is invalid")
    end
  end

  it 'アカウントが作成できるかどうか' do
    account = Account.new(email: valid_email, password: valid_password, birthday: valid_birthday, gender: "male")
    expect(account.save).to be_truthy
  end
end

