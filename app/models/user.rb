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

  def self.get_google_user_info(access_token)
    require 'net/http'
    require 'uri'
    require 'json'

    uri = URI("https://people.googleapis.com/v1/people/me?personFields=birthdays,genders,emailAddresses,names")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request["Authorization"] = "Bearer #{access_token}"

    response = http.request(request)
    JSON.parse(response.body)
  end

  # Google OAuth2 からユーザーを作成または検索する
  def self.from_omniauth(auth)
    access_token = auth.credentials.token
  
    # Google People API からユーザー情報を取得
    google_user_info = get_google_user_info(access_token)
  
    # メールアドレスで既存ユーザーを検索
    email = google_user_info["emailAddresses"].first["value"]
    user = User.where(email: email).first
  
    unless user
      # 生年月日と性別がGoogleアカウントに登録されているかを確認
      birthdate = google_user_info["birthdays"] ? parse_birthdate(google_user_info["birthdays"].first["date"]) : nil
      gender = google_user_info["genders"] ? google_user_info["genders"].first["value"] : nil
  
      # 生年月日または性別がない場合、例外を投げる
      if birthdate.nil?
        raise "生年月日が登録されていないため、Googleアカウントでログインできません。" 
      elsif gender.nil?
        raise "性別が登録されていないため、Googleアカウントでログインできません。"
      end
  
      # ユーザーが存在しない場合、新規作成
      user = User.create(
        email: email,
        password: Devise.friendly_token[0, 20],
        name: google_user_info["names"].first["displayName"],
        birthdate: birthdate,
        gender: gender
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
  def self.parse_birthdate(birthdate_hash)
    if birthdate_hash.present?
      year = birthdate_hash["year"]
      month = birthdate_hash["month"]
      day = birthdate_hash["day"]
      
      # 年、月、日が存在する場合に日付を生成
      Date.new(year, month, day) if year && month && day
    end
  rescue ArgumentError
    nil  # 無効な日付の場合はnilを返す
  end

  def self.parse_gender(gender_array)
    if gender_array.present? && gender_array.is_a?(Array)
      # 最初の性別データを取得
      gender_data = gender_array.first
      gender_data["value"] if gender_data.present? && gender_data["value"].present?
    end
  end


end



