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

  # registered_pagesにブックマーク（URL）を追加
  def add_bookmark(url:, name:)
    self.registered_pages ||= []  # registered_pages が nil の場合は空の配列を初期化

    # ブックマークとして保存するデータをハッシュとして扱う
    bookmark = { name: name, url: url }

    # 同じ URL がすでに登録されていないかを確認し、登録されていなければ追加
    unless self.registered_pages.any? { |b| b.is_a?(Hash) && b[:url] == url }
      self.registered_pages << bookmark
      save
    end
  end

  private

  def set_default_registered_pages
    self.registered_pages ||= []  # nil の場合は空配列を代入
  end
end



