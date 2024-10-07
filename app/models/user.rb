class User < ApplicationRecord
  # Devise のモジュール設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # registered_pages を配列として扱う
  serialize :registered_pages, Array  

  # パスワードのバリデーション
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  # registered_pagesがnilの場合に空配列を返す（デフォルト値を空配列にする）
  after_initialize :set_default_registered_pages, if: :new_record?

  private

  def set_default_registered_pages
    self.registered_pages ||= []  # nil の場合は空配列を代入
  end
end

