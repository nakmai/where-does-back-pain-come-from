# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                         provider: 'google_oauth2',
                                                                         uid: '123545',
                                                                         info: {
                                                                           email: 'test@google.com',
                                                                           name: 'Test User',
                                                                           first_name: 'Test',
                                                                           last_name: 'User'
                                                                         },
                                                                         credentials: {
                                                                           token: 'mock_token',
                                                                           refresh_token: 'mock_refresh_token',
                                                                           expires_at: Time.now + 1.week
                                                                         },
                                                                         extra: {
                                                                           raw_info: {
                                                                             birthday: '1990-01-01',
                                                                             gender: 'male'
                                                                           }
                                                                         }
                                                                       })
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
end
