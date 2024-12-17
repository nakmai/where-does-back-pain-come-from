# frozen_string_literal: true

class OrthopedicsController < ApplicationController
  def orthopedics_advice1; end

  def proceed_next
    # 条件に基づいて遷移先を決定
    if session[:all_form_registered] && session[:red_flag_registered]
      # 両方が登録されている場合は red_flag2 へ進む
      redirect_to red_flag2_path
    elsif session[:all_form_registered]
      # all_form が登録されている場合は red_flag へ進む
      redirect_to red_flag_path
    else
      redirect_to root_path, alert: '必要な登録が完了していません'
    end
  end

  def orthopedics_advice5
    render 'orthopedics_advice5'
  end

  def orthopedics_advice2; end

  def orthopedics_advice3; end
end
