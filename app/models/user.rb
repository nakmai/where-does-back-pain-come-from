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
  def self.get_google_user_info(_access_token)
    # 必要なライブラリを読み込む
    require 'net/http'  # HTTPリクエストを行うためのライブラリ
    require 'uri'       # URI（URL）を処理するためのライブラリ
    require 'json'      # JSON形式のデータを扱うためのライブラリ

    # Google People APIのエンドポイントを指定
    uri = URI('https://people.googleapis.com/v1/people/me?personFields=birthdays,genders,emailAddresses,names')

    # HTTPオブジェクトを作成し、SSLを使用してセキュアな通信を行う設定
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true # SSL接続を有効にする

    # GETリクエストを作成し、Authorizationヘッダーにアクセストークンを設定
    request = Net::HTTP::Get.new(uri.request_uri)
    request['Authorization'] = "Bearer #{access_token}" # Google OAuth2のアクセストークンを利用

    # Google People APIに対してリクエストを送信し、レスポンスを受け取る
    response = http.request(request)

    # レスポンスのボディをJSON形式に変換して返す
    JSON.parse(response.body)
  end

  # Google OAuth2 からユーザーを作成または検索する
  def self.from_omniauth(auth)
    access_token = auth.credentials.token

    # Google People API からユーザー情報を取得
    google_user_info = get_google_user_info(access_token)

    # メールアドレスを取得
    email = google_user_info['emailAddresses']&.first&.dig('value') || auth.info.email

    # 既存のユーザーを検索（Google API のデータ、または OmniAuth のデータを使用）
    user = User.where(email: email).first_or_initialize do |u|
      u.email = email
      u.password = Devise.friendly_token[0, 20]
      u.name = google_user_info['names']&.first&.dig('displayName') || auth.info.name

      # Google API からの生年月日と性別を取得（無い場合はnil）
      u.birthdate = if google_user_info['birthdays']
                      parse_birthdate(google_user_info['birthdays'].first['date'])
                    else
                      (auth.extra.raw_info.birthday if auth.extra&.raw_info&.birthday)
                    end
      u.gender = google_user_info['genders']&.first&.dig('value') || (auth.extra.raw_info.gender if auth.extra&.raw_info&.gender)

      u.provider = auth.provider
      u.uid = auth.uid
    end

    # ユーザーが新規作成された場合、保存
    user.save if user.new_record?

    user
  end

  def birthdate_cannot_be_in_the_future
    return unless birthdate.present? && birthdate > Date.today

    errors.add(:birthdate, '未来の日付は無効です')
  end

  private

  # registered_pagesのデフォルト値を設定
  def set_default_registered_pages
    self.registered_pages ||= [] # nil の場合は空配列を代入
  end

  # googlePeopleAPIの生年月日の解析処理
  def self.parse_birthdate(birthdate_hash)
    if birthdate_hash.present?
      year = birthdate_hash['year']
      month = birthdate_hash['month']
      day = birthdate_hash['day']

      # 年、月、日が存在する場合に日付を生成
      Date.new(year, month, day) if year && month && day
    end
  rescue ArgumentError
    nil # 無効な日付の場合はnilを返す
  end

  # googlePeopleAPIの性別の解析処理
  def self.parse_gender(gender_array)
    if gender_array.present? && gender_array.is_a?(Array)
      # 最初の性別データを取得
      gender_data = gender_array.first
<<<<<<< HEAD
      # 性別データが存在し、値が 'male' または 'female' の場合のみ返す。その他はnilを返す
=======
      # 性別データが存在し、値が "male" または "female" の場合のみ返す。その他はnilを返す
>>>>>>> d83ee46f6a74ffc7cff9ee3271ce5b3b2faeafbd
      gender_data['value'] if gender_data.present? && %w[male female].include?(gender_data['value'])
    else
      nil # 無効なデータの場合はnilを返す
    end
  end
end
