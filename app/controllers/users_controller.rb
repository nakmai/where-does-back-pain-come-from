class UsersController < ApplicationController

  def all_form
    # フォーム表示のアクション
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
    if age < 20 || age > 55
      redirect_to orthopedics_path
    elsif age >= 20 && age <= 55 && gender == "female"
      # 女性かつ 20歳以上55歳以下の場合、gynecology.html .erbにリダイレクト
      redirect_to gynecology_path
      # 男性性かつ 20歳以上55歳以下の場合、red_flag.html.erbページにリダイレクト
    elsif age >= 20 && age <= 55 && gender == "male"
      redirect_to red_flag_path
    else
      redirect_to root_path, alert: "無効なデータです"
    end
  end
end

  
  
