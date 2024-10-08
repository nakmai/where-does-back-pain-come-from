class ApplicationController < ActionController::Base
  # Devise のヘルパーメソッドを使えるようにする
  require_dependency 'users/guest_controller'


  # CSRF対策
  protect_from_forgery with: :exception

  # ログイン前にいたページを保存する
  before_action :store_user_location!, if: :storable_location?

  # サインイン後にリダイレクトするパスを決定する
  def after_sign_in_path_for(resource)
    root_path
    end

  # サインアウト後にリダイレクトするパスを決定する
  def after_sign_out_path_for(resource)
    root_path   # ログイン後はトップページへリダイレクト
  end

  private

  # GETリクエストで、Devise コントローラではなく、AJAXリクエストでもない場合、URLを保存する
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  # ログイン前にいたページのURLを保存する
  def store_user_location!
    session[:user_return_to] = request.fullpath if request.get? && !devise_controller? && !request.xhr?
  end
end

  
  
