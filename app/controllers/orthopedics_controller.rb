class OrthopedicsController < ApplicationController
  def orthopedics_advice1
    # ビューを表示するだけならこのままでOKです
  end

  def proceed_next
    # 条件に基づいて遷移先を決定
    if session[:all_form_registered] && session[:red_flag_registered]
      # 両方が登録されている場合は red_flag2 へ進む
      redirect_to red_flag2_path
    elsif session[:all_form_registered]
      # all_form が登録されている場合は red_flag へ進む
      redirect_to red_flag_path
    else
      # 条件が満たされていない場合のデフォルトの動作（必要に応じて調整）
      redirect_to root_path, alert: '必要な登録が完了していません'
    end
  end

  def orthopedics_advice5
    # ビジネスロジックやビューのレンダリングをここに記述
    render 'orthopedics_advice5'
  end

  def orthopedics_advice2
    # orthopedics_advice2 ビューを表示
  end

  def orthopedics_advice3
    # orthopedics_advice3 ビューを表示
  end
end
