require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user] # Deviseのマッピングを設定
    @user = create(:user) # FactoryBotでユーザーを作成
  end

  it 'logs in with valid credentials' do
    post :create, params: { user: { email: @user.email, password: 'Password123' } }
    expect(response).to redirect_to(root_url)
  end

  it 'rejects invalid credentials' do
    post :create, params: { user: { email: @user.email, password: 'wrongpassword' } }
    expect(response).to have_http_status(:unprocessable_entity)
  end
end
