class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[redirect_based_on_age_and_gender profile_page]

  def profile_page
    @user = User.find(params[:id])
    @bookmarks = @user.registered_pages || []
    render 'users/profile/profile_page'
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
<<<<<<< HEAD
  
    # 生年月日が入力されていない場合の処理
    if year.zero? || month.zero? || day.zero?
      @user_data = { year: year, month: month, day: day, gender: gender }
      flash.now[:alert] = '生年月日を入力してください。'
      render :all_form
      return
    end
  
    # 性別が選択されていない場合の処理
    if gender.blank?
      @user_data = { year: year, month: month, day: day, gender: gender }
      flash.now[:alert] = '性別を選択してください。'
      render :all_form
      return
    end
  
    # 正常な日付かどうかを確認するための処理
    begin
      birthdate = Date.new(year, month, day)
  
      # 未来の日付が入力された場合の処理
      if birthdate > Date.today
        @user_data = { year: year, month: month, day: day, gender: gender }
        flash.now[:alert] = '無効な日付が入力されました。'
        render :all_form
        return
      end
    rescue ArgumentError
      @user_data = { year: year, month: month, day: day, gender: gender }
      flash.now[:alert] = '無効な日付が入力されました。'
      render :all_form
      return
    end
  
    age = calculate_age(birthdate)
    redirect_based_on_age_and_gender(age, gender)
  end
  
=======

    # 年、月、日が無効な場合の処理
    if year.zero? || month.zero? || day.zero? || gender.blank?
      @user_data = { year: year, month: month, day: day, gender: gender }
      flash.now[:alert] = 'すべてのフィールドを入力してください。'
      render :all_form
      return
    end

    # 正常な日付かどうかを確認するための処理
    begin
      birthdate = Date.new(year, month, day)
    rescue ArgumentError
      @user_data = { year: year, month: month, day: day, gender: gender }
      flash.now[:alert] = '無効な日付が入力されました。'
      render :all_form
      return
    end

    age = calculate_age(birthdate)
    redirect_based_on_age_and_gender(age, gender)
  end
>>>>>>> d83ee46f6a74ffc7cff9ee3271ce5b3b2faeafbd

  # 年齢と性別に基づく共通のリダイレクト処理
  def redirect_based_on_age_and_gender
    user = current_user || session[:google_data] # current_user もしくは Google データを使う

    if user.present?
      birthdate = user[:birthdate] || user['birthdate']
      gender = user[:gender] || user['gender']
      age = calculate_age(birthdate)
      redirect_user_based_on_age_and_gender(age, gender)
    else
      redirect_to all_form_users_path # 生年月日や性別がない場合は入力フォームへ
    end
  end

  # Eメールログイン時のチェック
  def check_user_data
    # current_userがnilの場合はリダイレクト
    redirect_to all_form_users_path and return if current_user.nil?

    # current_userが存在する場合の処理
    if current_user.birthdate.present? && current_user.gender.present?
      age = calculate_age(current_user.birthdate)
      gender = current_user.gender
      redirect_based_on_age_and_gender(age, gender)
    else
      # 生年月日または性別がない場合もリダイレクト
      redirect_to all_form_users_path
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
    if user_signed_in?
      redirect_to @user_redirect_path
    else
      render @guest_template
    end
  end

  def cancel
    render 'devise/registrations/cancel'
  end

  # アカウントの削除
  def destroy
    resource.destroy # ユーザーの削除
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
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
    render 'users/user/nutation' # 適切なビューを表示
  end

  # ブックマーク追加・削除
  def add_bookmark
    if user_signed_in?
      url = params[:url].sub(/^http:/, 'https:')
      name = params[:name]

      if url.present? && name.present?
        if current_user.add_bookmark(url: url, name: name)
          redirect_to profile_page_user_path(current_user.id), notice: 'ページをマイページに登録しました。'
        else
          redirect_to profile_page_user_path(current_user.id), alert: 'ブックマークの保存に失敗しました。'
        end
      else
        redirect_to profile_page_user_path(current_user.id), alert: 'ブックマークするページが指定されていません。'
      end
    else
      redirect_to new_user_session_path, alert: 'ブックマークするにはログインが必要です。'
    end
  end

  def remove_bookmark
    url = params[:url].sub(/^http:/, 'https:')

    if url.present?
      current_user.remove_bookmark(url)
      redirect_to profile_page_user_path(current_user.id), notice: 'ブックマークを削除しました。'
    else
      redirect_to profile_page_user_path(current_user.id), alert: 'ブックマークの削除に失敗しました。'
    end
  end

  def remove_all_bookmarks
    current_user.registered_pages = [] # 全てのブックマークをクリア
    current_user.save
    redirect_to profile_page_user_path(current_user.id), notice: '全てのブックマークを削除しました。'
  end

  # インデックスと詳細ページ
  def index
    @user = current_user # 現在サインインしているユーザーを取得
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

  def ensure_user_logged_in
    # current_userがnilの場合はリダイレクト
    redirect_to all_form_users_path if current_user.nil?
  end

  # GoogleのAPIから生年月日と性別を取り出す
  def extract_google_data(auth)
    {
      birthdate: auth.extra.raw_info.birthday || auth.extra.raw_info.birthdate,
      gender: auth.extra.raw_info.gender
    }
  end

  # 生年月日から年齢を計算
  def calculate_age(birthdate)
    ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
  end

  # 年齢と性別に基づく共通のリダイレクト処理（引数を受け取る形に変更）
  def redirect_based_on_age_and_gender(age, gender)
    if age <= 20 || age >= 55
      redirect_to orthopedics_advice1_path
    elsif age >= 21 && age <= 54
      if gender == 'male'
        redirect_to red_flag_path
      elsif gender == 'female'
        redirect_to gynecology_question_path
      else
        redirect_to root_path, alert: '無効な性別データです。'
      end
    else
      redirect_to root_path, alert: '無効な年齢データです。'
    end
  end
end
