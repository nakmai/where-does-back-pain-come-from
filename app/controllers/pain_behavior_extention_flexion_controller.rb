class PainBehaviorExtentionFlexionController < ApplicationController
  # unknown_extention_behavior_flexion アクションを除外
  before_action :check_nothing_selections, except: :unknown_extention_behavior_flexion

  MAX_NOTHING_SELECTIONS = 7

  def check_nothing_selections
    session[:nothing_selections] ||= 0
    if session[:nothing_selections] >= MAX_NOTHING_SELECTIONS
      redirect_to pain_behavior_extention_flexion_unknown_extention_behavior_flexion_path and return
    end
  end

  def myofascial_back_pain_extention_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention_flexion/intervertebral_joint_extention_flexion_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/myofascial_back_pain'
    end
  end
  
  def intervertebral_joint_extention_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention_flexion/intervertebral_disk_extention_flexion_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/intervertebral_joint'
    end
  end

  def intervertebral_disk_extention_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention_flexion/nutation_extention_flexion_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/intervertebral_disk'
    end
  end

  def nutation_extention_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/nutation'
    end
  end

  def counternutation_extention_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/counternutation'
    end
  end

  # unknown_extention_behavior_flexion のアクション
  def unknown_extention_behavior_flexion
    reset_session
   render 'pain_behavior_extention_flexion/unknown_extention_flexion_behavior'
  end
end
