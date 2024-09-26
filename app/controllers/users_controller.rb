class Users < ApplicationRecord
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
    
    # パスワードのバリデーション
    validates :password, length: { minimum: 6 }, if: -> { password.present? }
  end
  
