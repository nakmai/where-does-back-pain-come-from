# app/controllers/oauth_controller.rb
class OauthController < ApplicationController
  def callback
    if params[:code]
      # Googleからの認証コードを受け取る
      code = params[:code]

      # アクセストークンを取得するためのリクエスト
      response = RestClient.post('https://oauth2.googleapis.com/token', {
                                   code: code,
                                   client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
                                   client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
                                   redirect_uri: 'https://your-heroku-app.herokuapp.com/oauth2callback',
                                   grant_type: 'authorization_code'
                                 })

      # トークン情報を保存するなどの処理
      tokens = JSON.parse(response.body)
      access_token = tokens['access_token']
      refresh_token = tokens['refresh_token']

      # トークンを保存し、必要なページへリダイレクトする
      # 例：ユーザーセッションに保存する、DBに保存するなど
      session[:access_token] = access_token
      session[:refresh_token] = refresh_token

      redirect_to root_path, notice: 'Successfully authenticated!'
    else
      redirect_to root_path, alert: 'Authentication failed'
    end
  end
end
