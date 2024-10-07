class ApplicationController < ActionController::Base
  # Devise のヘルパーメソッドを使えるようにする
  include Devise::Controllers::Helpers
  before_action :authenticate_user!
  skip_before_action :authenticate_user!
  # CSRF対策
  protect_from_forgery with: :exception

  # ログイン前にいたページを保存する
  before_action :store_user_location!, if: :storable_location?

  # サインイン後にリダイレクトするパスを決定する
  def after_sign_in_path_for(resource)
    if params[:return_to].present?
      return params[:return_to]
    end
    
    # 保存された場所、もしくはデフォルトのページ
    stored_location_for(resource) || my_page_myofascial_back_pain_path(resource)  # デフォルトをマイページに
  end

  # サインアウト後にリダイレクトするパスを決定する
  def after_sign_in_path_for(resource)
    logout_complete_path # ここでログイン後のリダイレクト先を指定
  end

  private

  # GETリクエストで、Devise コントローラではなく、AJAXリクエストでもない場合、URLを保存する
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  # ログイン前にいたページのURLを保存する
  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end

  
  
