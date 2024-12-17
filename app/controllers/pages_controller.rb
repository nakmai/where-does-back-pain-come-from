# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :check_user_status, only: [:check_user_data]
  skip_before_action :verify_authenticity_token, only: [:terms]

  def home
    render 'pages/home'
  end

  def terms
    # フォーム送信後にチェックボックスの状態を確認
    if request.post?
      terms_checked = params[:terms].present?
      privacy_checked = params[:privacy].present?

      if !terms_checked && !privacy_checked
        flash.now[:alert] = '利用規約とプライバシーポリシーを確認してください'
      elsif !terms_checked
        flash.now[:alert] = '利用規約を確認してください'
      elsif !privacy_checked
        flash.now[:alert] = 'プライバシーポリシーを確認してください'
      else
        # 全てチェックされている場合は次のステップへ
        redirect_to check_user_data_path and return
      end
    end
    render 'pages/terms'
  end

  def terms_of_use; end

  def privacy; end

  def check_user_data
    # current_userがnilでないか確認
    if current_user.nil?
      # current_userが存在しない（ログインしていない）場合はリダイレクト
      redirect_to all_form_users_path
      return
    end
    # current_userが存在する場合
    if current_user.birthdate.present? && current_user.gender.present?
      age = calculate_age(current_user.birthdate)
      gender = current_user.gender
      redirect_based_on_age_and_gender(age, gender)
    else
      # 生年月日と性別がない場合はall_form_users_pathにリダイレクト
      redirect_to all_form_users_path
    end
  end

  def gynecology; end

  def orthopedics; end

  private

  # ユーザーがログインしているか、Googleデータがあるか確認
  def check_user_status
    if user_signed_in?
      # ユーザーがログインしている場合はそのまま処理
      nil
    elsif session[:google_data].present?
      # Googleログイン後の処理（セッションデータから）
      redirect_based_on_age_and_gender(session[:google_data])
    else
      # ログインしていない場合、all_form_users_pathにリダイレクト
      redirect_to all_form_users_path
    end
  end

  # current_userが存在しない場合にリダイレクト
  def ensure_user_logged_in
    return unless current_user.nil?

    redirect_to all_form_users_path
  end

  public
  # 生年月日から年齢を計算
  def calculate_age(birthdate)
    ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
  end

  # 年齢と性別によるリダイレクト
  def redirect_based_on_age_and_gender(user)
    age = calculate_age(user.birthdate)
    gender = user.gender

    if age <= 20 || age >= 56
      redirect_to orthopedics_advice1_path
    elsif age >= 21 && age <= 55
      if gender == 'male'
        redirect_to red_flag_path
      elsif gender == 'female'
        redirect_to gynecology_question_path
      end
    else
      redirect_to root_path, alert: '無効なデータです'
    end
  end
end
