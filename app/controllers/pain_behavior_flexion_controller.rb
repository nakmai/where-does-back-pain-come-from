# frozen_string_literal: true

class PainBehaviorFlexionController < ApplicationController
  before_action :check_nothing_selections, except: :unknown_flexion_behavior

  MAX_NOTHING_SELECTIONS = 7

  def check_nothing_selections
    session[:nothing_selections] ||= 0
    return unless session[:nothing_selections] >= MAX_NOTHING_SELECTIONS

    redirect_to action: :unknown_flexion_behavior and return
  end

  def myofascial_back_pain_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_flexion/intervertebral_disk_flexion_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/myofascial_back_pain'
    end
  end

  def intervertebral_disk_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_flexion/nutation_flexion_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/intervertebral_disk'
    end
  end

  def nutation_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_flexion/counternutation_flexion_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/nutation'
    end
  end

  def counternutation_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/counternutation'
    end
  end

  def unknown_flexion_behavior
    reset_session
    render 'pain_behavior_flexion/unknown_flexion_behavior'
  end
end
