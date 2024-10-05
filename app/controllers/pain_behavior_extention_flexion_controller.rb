class PainBehaviorExtentionFlexionController < ApplicationController
  before_action :authenticate_user!, except: [
    :myofascial_back_pain_extention_flexion_behavior,
    :intervertebral_joint_extention_flexion_behavior,
    :intervertebral_disk_extention_flexion_behavior,
    :nutation_extention_flexion_behavior,
    :counternutation_extention_flexion_behavior,
  ]
  
  def myofascial_back_pain_extention_flexion_behavior
      conditions = params[:conditions] || []
      if conditions.include?('nothing')
        render 'pain_behavior_extention_flexion/intervertebral_joint_extention_flexion_behavior'
      else
        render 'diagnostic_result/myofascial_back_pain'
      end
    end
  
    # 椎間関節ページの処理
    def intervertebral_joint_extention_flexion_behavior
      conditions = params[:conditions] || []
      if conditions.include?('nothing')
        render 'pain_behavior_extention_flexion/intervertebral_disk_extention_flexion_behavior'
      else
        render 'diagnostic_result/intervertebral_joint'
      end
    end
  
    # 椎間板ページの処理
    def intervertebral_disk_extention_flexion_behavior
      conditions = params[:conditions] || []
      if conditions.include?('nothing')
        render 'pain_behavior_extention_flexion/nutation_extention_flexion_behavior'
      else
        render 'diagnostic_result/intervertebral_disk'
      end
    end
  
    # 仙骨の前傾ページの処理
    def nutation_extention_flexion_behavior
      conditions = params[:conditions] || []
      if conditions.include?('nothing')
        render 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior'
      else
        render 'diagnostic_result/nutation'
      end
    end
  
    # 仙骨の後傾ページの処理
    def counternutation_extention_flexion_behavior
logger.debug "Processing counternutation_extention_flexion_behavior action"
      conditions = params[:conditions] || []
      if conditions.include?('nothing')
        render 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior'
      else
        render 'diagnostic_result/counternutation'
      end
    end
  end

