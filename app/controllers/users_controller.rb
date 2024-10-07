class UsersController < ApplicationController
  before_action :store_user_location!, if: :storable_location?
  
  def all_form
    render 'users/all_form'
  end

  def submit_form
    year = params[:year].to_i
    month = params[:month].to_i
    day = params[:day].to_i
    gender = params[:gender]

    if year.zero? || month.zero? || day.zero? || gender.blank?
      redirect_to users_all_form_path, alert: "すべての項目を正しく入力してください"
      return
    end

    begin
      birthdate = Date.new(year, month, day)
      age = ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
    rescue ArgumentError
      redirect_to users_all_form_path, alert: "無効な日付が入力されました"
      return
    end

    if age < 21 || age > 55
      redirect_to orthopedics_advice1_path
    elsif age >= 21 && age <= 55 && gender == "female"
      redirect_to gynecology_question_path
    elsif age >= 21 && age <= 55 && gender == "male"
      redirect_to red_flag_path
    else
      redirect_to root_path, alert: "無効なデータです"
    end
  end

  def counternutation_user
    if user_signed_in?
      render 'users/user/counternutation'  # ユーザー用テンプレートをレンダリング
    else
      redirect_to my_page_counternutation_guest_path  # ログインしていない場合はゲスト用ページへリダイレクト
    end
  end

  # ゲスト用のcounternutationページを表示するアクション
  def counternutation_guest
    unless user_signed_in?
      render 'users/guest/counternutation'  # ゲスト用テンプレートをレンダリング
    else
      redirect_to my_page_counternutation_user_path  # ログインしている場合はユーザー用ページへリダイレクト
    end
  end
  def intervertebral_disk_user
    if user_signed_in?
      render 'users/user/intervertebral_disk'
    else
      redirect_to my_page_intervertebral_disk_guest_path
    end
  end

  def intervertebral_disk_guest
    unless user_signed_in?
      render 'users/guest/intervertebral_disk'
    else
      redirect_to my_page_intervertebral_disk_user_path
    end
  end

  # Intervertebral Joint
  def intervertebral_joint_user
    if user_signed_in?
      render 'users/user/intervertebral_joint'
    else
      redirect_to my_page_intervertebral_joint_guest_path
    end
  end

  def intervertebral_joint_guest
    unless user_signed_in?
      render 'users/guest/intervertebral_joint'
    else
      redirect_to my_page_intervertebral_joint_user_path
    end
  end

  # Myofascial Back Pain
  def myofascial_back_pain_user
    if user_signed_in?
      render 'users/user/myofascial_back_pain'
    else
      redirect_to my_page_myofascial_back_pain_guest_path
    end
  end

  def myofascial_back_pain_guest
    unless user_signed_in?
      render 'users/guest/myofascial_back_pain'
    else
      redirect_to my_page_myofascial_back_pain_user_path
    end
    render 'diagnostic_result/myofascial_back_pain'
  end

  # Nutation
  def nutation_user
    if user_signed_in?
      render 'users/user/nutation'
    else
      redirect_to my_page_nutation_guest_path
    end
  end

  def nutation_guest
    unless user_signed_in?
      render 'users/guest/nutation'
    else
      redirect_to my_page_nutation_user_path
    end
  end
end



