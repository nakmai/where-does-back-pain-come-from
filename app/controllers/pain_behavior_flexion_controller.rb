class PainBehaviorFlexionController < ApplicationController

  before_action :authenticate_user!, except: [
    :myofascial_back_pain_flexion_behavior,
    :intervertebral_disk_flexion_behavior,
    :counternutation_flexion_behavior,
    :nutation_flexion_behavior
  ]
  
  # 筋膜性腰痛ページの処理
  def myofascial_back_pain_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      render 'pain_behavior_flexion/intervertebral_disk_flexion_behavior'
    else
      render 'diagnostic_result/myofascial_back_pain'
    end
  end

  # 椎間板ページの処理
  def intervertebral_disk_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      render 'pain_behavior_flexion/nutation_flexion_behavior'
    else
      render 'diagnostic_result/intervertebral_disk'
    end
  end

  # カウンターニューテーションページの処理
  # ニューテーションページの処理
  def nutation_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      render 'pain_behavior_flexion/counternutation_flexion_behavior' 
    else
      render 'diagnostic_result/nutation'
    end
  end
  

  # カウンターニューテーションページの処理
  def counternutation_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      render 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior'
    else
      render 'diagnostic_result/counternutation'
    end
  end

end

  
  