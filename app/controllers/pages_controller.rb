class PagesController < ApplicationController
  def home
    render 'pages/home'
  end

  def terms
    # まず利用規約ページを表示する
    render 'pages/terms'
  end

  def check_user_data
    # ユーザーの生年月日と性別を確認
    if current_user.birthdate.present? && current_user.gender.present?
      age = calculate_age(current_user.birthdate)
      gender = current_user.gender
      redirect_based_on_age_and_gender(age, gender)
    else
      # 生年月日と性別がない場合は、all_formページへ
      redirect_to all_form_users_path
    end
  end

    def gynecology
      # 婦人科
    end

    def orthopedics
      # 整形外科
    end
    private

    def check_user_status
      if user_signed_in?
        redirect_based_on_age_and_gender(current_user)
      elsif session[:google_data].present?
        # Googleログイン後の処理
        redirect_based_on_age_and_gender(session[:google_data])
      else
        redirect_to terms_path unless action_name == 'terms'
      end
    end

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
        redirect_to root_path, alert: "無効なデータです"
      end
    end
  end
