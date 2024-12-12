# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Devise のヘルパーメソッドを使えるようにする
  require_dependency 'users/guest_controller'
  # CSRF対策
  protect_from_forgery with: :exception
  # ログイン前にいたページを保存する
  before_action :store_user_location!, if: :storable_location?

  def after_sign_in_path_for(resource)
    # ログイン後はまずトップページへリダイレクト
    stored_location_for(resource) || root_path
  end

  # Googleログイン時のリダイレクト処理

  # サインアウト後にリダイレクトするパスを決定する
  def after_sign_out_path_for(_resource)
    root_path # ログイン後はトップページへリダイレクト
  end

  private

  # GETリクエストで、Devise コントローラではなく、AJAXリクエストでもない場合、URLを保存する
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    session[:user_return_to] = request.fullpath if storable_location?
  end

  def calculate_age(birthdate)
    ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
  end

  def redirect_based_on_age_and_gender(age, gender)
    if age <= 20 || age >= 55
      orthopedics_advice1_path
    elsif age >= 21 && age <= 54
      if gender == 'male'
        red_flag_path
      elsif gender == 'female'
        gynecology_question_path
      else
        root_path
      end
    else
      root_path
    end
  end
end
