class UsersController < ApplicationController
  before_action :store_user_location!, if: :storable_location?

  def all_form
    # ロジックをここに追加
    render 'users/all_form'
  end

  def submit_form
    # フォームから送信されたデータを取得
    year = params[:year].to_i
    month = params[:month].to_i
    day = params[:day].to_i
    gender = params[:gender]

    # 生年月日が正しく入力されていない場合の処理
    if year.zero? || month.zero? || day.zero? || gender.blank?
      redirect_to users_all_form_path, alert: "すべての項目を正しく入力してください"
      return
    end

    # 生年月日から年齢を計算
    begin
      birthdate = Date.new(year, month, day)
      age = ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
    rescue ArgumentError
      # 無効な日付が入力された場合
      redirect_to users_all_form_path, alert: "無効な日付が入力されました"
      return
    end

    # 条件に基づいてリダイレクト
    if age < 21 || age > 55
      # 21歳未満または55歳以上の場合、orthopedics_adviceページにリダイレクト
      redirect_to orthopedics_advice1_path
    elsif age >= 21 && age <= 55 && gender == "female"
      # 女性で 21歳以上55歳以下の場合、gynecology_questionページにリダイレクト
      redirect_to gynecology_question_path
    elsif age >= 21 && age <= 55 && gender == "male"
      # 男性で 20歳以上55歳以下の場合、レッドフラッグページにリダイレクト
      redirect_to red_flag_path
    else
      # その他無効なデータの場合はルートにリダイレクト
      redirect_to root_path, alert: "無効なデータです"
    end
  end

  def my_page_myofascial_back_pain
    @user = current_user
  
    if request.post?
      unless @user.registered_pages.include?('myofascial_back_pain')
        @user.registered_pages << 'myofascial_back_pain'  # 配列にページ名を追加
        @user.save  # 保存
        flash[:notice] = "マイページに登録されました"
      else
        flash[:alert] = "このページは既に登録されています"
      end
  
      redirect_to users_profile_page_path(@user)  # プロフィールページにリダイレクト
    else
      render 'my_page/my_page_myofascial_back_pain'  # 直接アクセスの場合
    end
  end

  def copy_myofascial_back_pain
    source_file = Rails.root.join('app', 'views', 'my_page', 'my_page_myofascial_back_pain.html.erb')
    destination_file = Rails.root.join('app', 'views', 'users', 'show.html.erb')

    # ファイルの内容を読み込んでコピーします。
    if File.exist?(source_file)
      file_content = File.read(source_file)
      File.write(destination_file, file_content)
      flash[:notice] = "Myofascial Back Painの内容が正常にコピーされました。"
    else
      flash[:alert] = "コピー元のファイルが見つかりません。"
    end

    # ユーザーのマイページにリダイレクト
    redirect_to user_path(current_user)
  end
  
  
  def my_page
    @user = current_user

    # return_to パラメータが存在する場合はそのURLにリダイレクト
    if params[:return_to].present?
      redirect_to params[:return_to]
    else
      # それ以外の場合はユーザープロフィールページなどへリダイレクト
      redirect_to user_path(@user), notice: "マイページが正常に更新されました"
    end
  end

  def profile_page
    @user = current_user
  
    if @user.registered_pages.empty?
      redirect_to root_path, alert: "マイページに登録されていません。"
    else
      # 登録されているページに基づいてリダイレクト
      if @user.registered_pages.include?('counternutation')
        redirect_to my_page_counternutation_path(@user)
      elsif @user.registered_pages.include?('intervertebral_disk')
        redirect_to my_page_intervertebral_disk_path(@user)
      elsif @user.registered_pages.include?('intervertebral_joint')
        redirect_to my_page_intervertebral_joint_path(@user)
      elsif @user.registered_pages.include?('myofascial_back_pain')
        redirect_to my_page_myofascial_back_pain_path(@user)
      elsif @user.registered_pages.include?('nutation')
        redirect_to my_page_nutation_path(@user)
      else
        render 'users/profile/profile_page'  # どれにも該当しない場合は通常のビューを表示
      end
    end
  end
  
  
  

  def register_page
    page = params[:page] # 'counternutation'などページ識別子を取得
    current_user.registered_pages << page unless current_user.registered_pages.include?(page)
    current_user.save
    redirect_to user_profile_path # 適切なリダイレクト先に
  end
end




