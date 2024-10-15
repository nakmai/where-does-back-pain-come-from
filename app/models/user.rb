class User < ApplicationRecord
  # Devise のモジュール設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  # registered_pages を配列として扱う
  serialize :registered_pages, Array

  # パスワードのバリデーション
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  # 生年月日と性別のバリデーション
  validates :birthdate, presence: true
  validates :gender, presence: true, inclusion: { in: %w(male female), message: "性別を選んでください" }

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

  # registered_pagesからブックマークを削除
  def remove_bookmark(url)
    self.registered_pages ||= []  # nilの場合は空の配列を初期化

    # URLに該当するブックマークを削除
    self.registered_pages.delete_if { |bookmark| bookmark[:url] == url }

    save  # 保存
  end

  # Google OAuth2 からユーザーを作成または検索する
  def self.from_omniauth(auth)
    # すでにユーザーが存在するかをメールで確認
    user = User.where(email: auth.info.email).first

    unless user
      # ユーザーが存在しない場合、新規作成
      user = User.create(
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        name: auth.info.name,
        birthdate: parse_birthdate(auth.extra.raw_info.birthday),
        gender: auth.extra.raw_info.gender
      )
    end

    user
  end

  private

  # registered_pagesのデフォルト値を設定
  def set_default_registered_pages
    self.registered_pages ||= []  # nil の場合は空配列を代入
  end

  # 生年月日の解析処理
  def self.parse_birthdate(birthday_string)
    Date.parse(birthday_string) if birthday_string.present?
  rescue ArgumentError
    nil  # 無効な日付の場合はnilを返す
  end
end



