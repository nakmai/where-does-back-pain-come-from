# frozen_string_literal: true

class PainController < ApplicationController
  def red_flag
    flash.clear
  end

  def submit_red_flag
    flash.clear
    conditions = params[:conditions] || []

    # チェックボックスが選択されていない場合
    if conditions.empty?
      flash.now[:alert] = '選択してください'
      @conditions = conditions
      render :red_flag
      return
    end
    # 「特に問題なし」と他の項目が両方選ばれている場合
    if conditions.include?('no_issues') && conditions.length > 1
      flash.now[:alert] = '無効な選択です'
      @conditions = conditions
      render :red_flag
      return
    end

    # 特に問題なしのみがチェックされている場合
    if conditions.include?('no_issues') && conditions.length == 1
      redirect_to red_flag2_path
    else
      # 他の項目がチェックされている場合
      redirect_to orthopedics_advice2_path
    end
  end

  def red_flag2
    flash.clear
  end

  def red_flag2_submit
    flash.clear
    conditions = params[:conditions] || []

    # チェックボックスが選択されていない場合
    if conditions.empty?
      flash.now[:alert] = '選択してください'
      @conditions = conditions
      render :red_flag2
      return
    end

    # 「特に問題なし」と他の項目が両方選ばれている場合
    if conditions.include?('no_issues') && conditions.length > 1
      flash.now[:alert] = '無効な選択です'
      @conditions = conditions
      render :red_flag2
      return
    end

    # 「特に問題なし」が選択されている場合
    if conditions.include?('no_issues')
      redirect_to pain_scale_path
    else
      # 他の項目が選択されている場合
      redirect_to orthopedics_advice3_path
    end
  end

  def red_flag3
    flash.clear
  end

  def red_flag3_submit
    flash.clear
    conditions = params[:conditions] || []

    # チェックボックスが選択されていない場合
    if conditions.empty?
      flash.now[:alert] = '選択してください'
      @conditions = conditions
      render :red_flag3 # 再表示
      return
    end

    # 特定の条件が選ばれた場合、orthopedics_advice5_pathにリダイレクト
    pain_conditions = %w[severe_pain no_rest_pain pain_at_rest pain_at_norest wake_from_pain
                         sleep_disorder]

    # 上記のいずれかの条件が選ばれた場合、リダイレクト
    if (pain_conditions & conditions).any?
      redirect_to orthopedics_advice5_path
      return
    end

    # 「特になし」が選ばれている場合のリダイレクト
    if conditions.include?('no_issues')
      redirect_to pain_location_extention_flexion_path
      return
    end

    # 「特になし」と no_pain や no_pain2 の条件が選ばれている場合にリダイレクト
    if conditions.include?('no_issues') && (conditions.include?('no_pain') || conditions.include?('no_pain2'))
      redirect_to pain_location_extention_flexion_path
      return
    end

    # それ以外の条件でのリダイレクト
    if conditions.include?('no_pain') || conditions.include?('no_pain2')
      redirect_to pain_location_extention_flexion_path
      return
    end

    # 最後に、どの条件にも該当しない場合は、再度 red_flag3 を表示
    render :red_flag3
  end

  def pain_scale; end

  def submit_pain_scale
    pain_level = params[:pain_level].to_i

    if pain_level >= 6
      redirect_to orthopedics_advice5_path
    else
      redirect_to achlorhydria_path
    end
  end

  def achlorhydria; end

  def orthopedics_advice1; end

  def orthopedics_advice2; end

  def orthopedics_advice3; end

  def orthopedics_advice5; end
end
