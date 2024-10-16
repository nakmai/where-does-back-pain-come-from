class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:redirect_based_on_age_and_gender, :profile_page]


  def profile_page
    @user = User.find(params[:id])
    @bookmarks = @user.registered_pages || []
    render 'users/profile/profile_page'  # app/views/users/profile/profile_page.html.erb が必要です
  end


  def all_form
    @user_data = { year: nil, month: nil, day: nil, gender: nil }
    render 'users/all_form'
  end

  def submit_form
    year = params[:year].to_i
    month = params[:month].to_i
    day = params[:day].to_i
    gender = params[:gender]

    birthdate = Date.new(year, month, day)
    age = calculate_age(birthdate)

    redirect_based_on_age_and_gender(age, gender)
  end

  # ログイン済みユーザーの場合
  def redirect_based_on_age_and_gender
    user = current_user

    if user.birthday.present? && user.gender.present?
      age = calculate_age(user.birthday)
      gender = user.gender

      redirect_user_based_on_age_and_gender(age, gender)
    else
      redirect_to all_form_path
    end
  end

  # Googleログイン時のデータ取得処理
  def google_oauth2_callback
    auth = request.env['omniauth.auth']
    birthday = auth.extra.raw_info.birthday
    gender = auth.extra.raw_info.gender

    if birthday.present? && gender.present?
      birthdate = Date.parse(birthday)
      age = calculate_age(birthdate)
      redirect_based_on_age_and_gender(age, gender)
    else
      redirect_to all_form_path
    end
  end


  # ユーザー用ページのアクション
  def user_page
    if user_signed_in?
      render @user_template
    else
      redirect_to @guest_redirect_path
    end
  end

  # ゲスト用ページのアクション
  def guest_page
    unless user_signed_in?
      render @guest_template
    else
      redirect_to @user_redirect_path
    end
  end

  def counternutation
    if user_signed_in?
      render 'users/user/counternutation'
    else
      render 'users/guest/counternutation'
    end
  end

  def counternutation_user
    # ここに必要な処理を記述します
    render 'users/user/counternutation'
  end

  def counternutation_guest
    # ここに必要な処理を記述します
    render 'users/guest/counternutation'
  end

  def intervertebral_disk
    if user_signed_in?
      render 'users/user/intervertebral_disk'
    else
      render 'users/guest/intervertebral_disk'
    end
  end

  def intervertebral_disk_user
    # 必要な処理をここに追加してください
    render 'users/user/intervertebral_disk' # 適切なビューを指定します
  end

  def intervertebral_joint
    if user_signed_in?
      render 'users/user/intervertebral_joint'
    else
      render 'users/guest/intervertebral_joint'
    end
  end

  def myofascial_back_pain
    if user_signed_in?
      render 'users/user/myofascial_back_pain'
    else
      render 'users/guest/myofascial_back_pain'
    end
  end

  def nutation
    if user_signed_in?
      render 'users/user/nutation'
    else
      render 'users/guest/nutation'
    end
  end
  

  def nutation_guest
    render 'users/guest/nutation'
  end

  def nutation_user
    render 'users/user/nutation'  # 適切なビューを表示
  end

  # ブックマーク追加・削除
  def add_bookmark
    if user_signed_in?
      url = params[:url].sub(/^http:/, 'https:')
      name = params[:name]
  
      if url.present? && name.present?
        if current_user.add_bookmark(url: url, name: name)
          redirect_to profile_page_user_path(current_user.id), notice: "ページをマイページに登録しました。"
        else
          redirect_to profile_page_user_path(current_user.id), alert: "ブックマークの保存に失敗しました。"
        end
      else
        redirect_to profile_page_user_path(current_user.id), alert: "ブックマークするページが指定されていません。"
      end
    else
      redirect_to new_user_session_path, alert: "ブックマークするにはログインが必要です。"
    end
  end

  def remove_bookmark
    url = params[:url].sub(/^http:/, 'https:')

    if url.present?
      current_user.remove_bookmark(url)
      redirect_to profile_page_user_path(current_user.id), notice: "ブックマークを削除しました。"
    else
      redirect_to profile_page_user_path(current_user.id), alert: "ブックマークの削除に失敗しました。"
    end
  end

  def remove_all_bookmarks
    current_user.registered_pages = []  # 全てのブックマークをクリア
    current_user.save
    redirect_to profile_page_user_path(current_user.id), notice: "全てのブックマークを削除しました。"
  end

  # プロフィールページ
  def profile_page
    @user = User.find(params[:id])
    @bookmarks = @user.registered_pages || []
    render 'users/profile/profile_page'
  end

  # インデックスと詳細ページ
  def index
    @user = current_user  # 現在サインインしているユーザーを取得
  end

  def show
    @user = User.find(params[:id])
    @bookmarks = @user.registered_pages || []
  end

  private

  def set_template_paths
    case action_name
    when 'counternutation_user', 'counternutation_guest'
      @user_template = 'users/user/counternutation'
      @guest_template = 'users/guest/counternutation'
      @guest_redirect_path = my_page_counternutation_guest_path
      @user_redirect_path = my_page_counternutation_user_path
    when 'intervertebral_disk_user', 'intervertebral_disk_guest'
      @user_template = 'users/user/intervertebral_disk'
      @guest_template = 'users/guest/intervertebral_disk'
      @guest_redirect_path = my_page_intervertebral_disk_guest_path
      @user_redirect_path = my_page_intervertebral_disk_user_path
    when 'intervertebral_joint_user', 'intervertebral_joint_guest'
      @user_template = 'users/user/intervertebral_joint'
      @guest_template = 'users/guest/intervertebral_joint'
      @guest_redirect_path = my_page_intervertebral_joint_guest_path
      @user_redirect_path = my_page_intervertebral_joint_user_path
    when 'myofascial_back_pain_user', 'myofascial_back_pain_guest'
      @user_template = 'users/user/myofascial_back_pain'
      @guest_template = 'users/guest/myofascial_back_pain'
      @guest_redirect_path = my_page_myofascial_back_pain_guest_path
      @user_redirect_path = my_page_myofascial_back_pain_user_path
    when 'nutation_user', 'nutation_guest'
      @user_template = 'users/user/nutation'
      @guest_template = 'users/guest/nutation'
      @guest_redirect_path = my_page_nutation_guest_path
      @user_redirect_path = my_page_nutation_user_path
    end
  end

  def calculate_age(birthday)
    ((Time.zone.now - birthday.to_time) / 1.year.seconds).floor
  end

  def redirect_based_on_age_and_gender(age, gender)
    if age <= 20 || age >= 55
      redirect_to orthopedics_advice1_path
    elsif age >= 21 && age <= 54
      if gender == "male"
        redirect_to red_flag_path
      elsif gender == "female"
        redirect_to gynecology_question_path
      else
        redirect_to root_path, alert: "無効なデータです"
      end
    else
      redirect_to root_path, alert: "無効なデータです"
    end
  end
end