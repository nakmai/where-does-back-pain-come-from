# frozen_string_literal: true

class PainBehaviorExtentionController < ApplicationController
  before_action :check_nothing_selections, except: :unknown_extention_behavior

  MAX_NOTHING_SELECTIONS = 7

  def check_nothing_selections
    session[:nothing_selections] ||= 0
    return unless session[:nothing_selections] >= MAX_NOTHING_SELECTIONS

    redirect_to pain_behavior_extention_unknown_extention_behavior_path and return
  end

  def myofascial_back_pain_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention/intervertebral_joint_extention_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/myofascial_back_pain'
    end
  end

  def intervertebral_joint_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention/nutation_extention_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/intervertebral_joint'
    end
  end

  def nutation_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention/counternutation_extention_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/nutation'
    end
  end

  def counternutation_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention/myofascial_back_pain_extention_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/counternutation'
    end
  end

  def unknown_extention_behavior
    reset_session
    render 'pain_behavior_extention/unknown_extention_behavior'
  end
end
