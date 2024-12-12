# frozen_string_literal: true

class User < ApplicationRecord
  # Devise のモジュール設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  # ユーザーは複数のブックマークを持つ
  has_many :bookmarks, dependent: :destroy
  # registered_pages を配列として扱う
  serialize :registered_pages, Array

  # バリデーション設定
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :birthdate, presence: true, on: :update
  validates :gender, presence: true, inclusion: { in: %w[male female], message: '性別を選んでください' }
  validate :birthdate_cannot_be_in_the_future

  # registered_pagesがnilの場合に空配列を返す（デフォルト値を空配列にする）
  after_initialize :set_default_registered_pages, if: :new_record?

  # registered_pagesにブックマーク（URL）を追加
  def add_bookmark(url:, name:)
    self.registered_pages ||= [] # nilの場合は空の配列を初期化
    bookmark = { name: name, url: url }

    # URLが重複していないかチェックしてから追加
    return if self.registered_pages.any? { |b| b[:url] == url }

    self.registered_pages << bookmark
    save
  end

  # registered_pagesからブックマークを削除
  def remove_bookmark(url)
    self.registered_pages ||= [] # nilの場合は空の配列を初期化

    # URLに該当するブックマークを削除
    self.registered_pages.delete_if { |bookmark| bookmark[:url] == url }

    save # 保存
  end

  # Google People API を使用して、ユーザーの情報（生年月日、性別、メールアドレス、名前など）を取得するメソッド
  def self.get_google_user_info(access_token)
    require 'net/http'
    require 'uri'
    require 'json'

    uri = URI('https://people.googleapis.com/v1/people/me?personFields=birthdays,genders,emailAddresses,names')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request['Authorization'] = "Bearer #{access_token}"

    response = http.request(request)
    JSON.parse(response.body)
  end

  # Google OAuth2 からユーザーを作成または検索する
  def self.from_omniauth(auth)
    access_token = auth['credentials']['token']
    google_user_info = get_google_user_info(access_token)
    email = google_user_info['emailAddresses']&.first&.dig('value') || auth.info.email

    user = User.where(email: email).first_or_initialize do |u|
      u.email = email
      u.password = Devise.friendly_token[0, 20]
      u.name = google_user_info['names']&.first&.dig('displayName') || auth.info.name
      u.birthdate = parse_birthdate(google_user_info['birthdays']&.first&.dig('date')) ||
                    auth.extra.raw_info.birthday
      u.gender = google_user_info['genders']&.first&.dig('value') ||
                 auth.extra.raw_info.gender
      u.provider = auth.provider
      u.uid = auth.uid
    end

    user.save if user.new_record?
    user
  end

  def birthdate_cannot_be_in_the_future
    return unless birthdate.present? && birthdate > Date.today

    errors.add(:birthdate, '未来の日付は無効です')
  end

  private

  def set_default_registered_pages
    self.registered_pages ||= []
  end

  def self.parse_birthdate(birthdate_hash)
    return unless birthdate_hash.present?

    year = birthdate_hash['year']
    month = birthdate_hash['month']
    day = birthdate_hash['day']

    Date.new(year, month, day) if year && month && day
  rescue ArgumentError
    nil
  end

  def self.parse_gender(gender_array)
    return unless gender_array.present? && gender_array.is_a?(Array)

    gender_data = gender_array.first
    gender_data['value'] if gender_data.present? && %w[male female].include?(gender_data['value'])
  end

  private_class_method :parse_birthdate, :parse_gender
end
