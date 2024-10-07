class PainBehaviorExtentionController < ApplicationController
  
 
  # 筋膜性腰痛ページの処理
  def myofascial_back_pain_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      render 'pain_behavior_extention/intervertebral_joint_extention_behavior'
    else
      render 'diagnostic_result/myofascial_back_pain'
    end
  end

  # 椎間関節ページの処理
  def intervertebral_joint_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      render 'pain_behavior_extention/nutation_extention_behavior'
    else
      render 'diagnostic_result/intervertebral_joint'

    end
  end

  # カウンターニューテーションページの処理
  # ニューテーションページの処理
  def nutation_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      render 'pain_behavior_extention/counternutation_extention_behavior' 
    else
      render 'diagnostic_result/nutation'
    end
  end
  

  # カウンターニューテーションページの処理
  def counternutation_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      render 'pain_behavior_extention/myofascial_back_pain_extention_behavior'
    else
      render 'diagnostic_result/counternutation'
    end
  end

end


