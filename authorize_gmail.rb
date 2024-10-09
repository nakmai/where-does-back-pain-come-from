require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Your Application Name'.freeze
CLIENT_SECRETS_PATH = 'path/to/your/client_secret.json'.freeze
SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_SEND

# クレデンシャルを取得するメソッド
def authorize
  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: 'token.yaml')
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts "Open the following URL in your browser and authorize the application:\n#{url}"
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

credentials = authorize


require 'mail'

# GmailのSMTP設定
options = {
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'yourdomain.com',
  authentication: :xoauth2,
  user_name: 'your_email@gmail.com',
  oauth2_token: credentials.token,  # 先ほど取得したアクセストークンを使用
  enable_starttls_auto: true
}

Mail.defaults do
  delivery_method :smtp, options
end

# メール送信の例
mail = Mail.new do
  from    'your_email@gmail.com'
  to      'recipient@example.com'
  subject 'OAuthを使ったGmail SMTPテスト'
  body    'これはOAuth認証を使用して送信されたメールです。'
end

mail.deliver!
