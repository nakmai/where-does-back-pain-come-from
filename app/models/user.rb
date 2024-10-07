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
    self.registered_pages ||= []  # nilの場合は空の配列を初期化
    bookmark = { name: name, url: url }
    
    # URLが重複していないかチェックしてから追加
    unless self.registered_pages.any? { |b| b[:url] == url }
      self.registered_pages << bookmark
      save
    end
  end

  def remove_bookmark(url)
    self.registered_pages ||= []  # nilの場合は空の配列を初期化
    
    # URLに該当するブックマークを削除
    self.registered_pages.delete_if { |bookmark| bookmark[:url] == url }
    
    save  # 保存
  end

  private

  def set_default_registered_pages
    self.registered_pages ||= []  # nil の場合は空配列を代入
  end
end



