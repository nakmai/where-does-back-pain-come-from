# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'Password123' }
    birthdate { '1990-01-01' }
    gender { 'male' }
  end
end
