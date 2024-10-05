class PainBehaviorExtentionFlexionController < ApplicationController
  #CSRFトークン対応
  protect_from_forgery with: :null_session

  before_action :authenticate_user!, except: [
    :myofascial_back_pain_extention_flexion_behavior,
    :intervertebral_joint_extention_flexion_behavior,
    :intervertebral_disk_extention_flexion_behavior,
    :nutation_extention_flexion_behavior,
    :counternutation_extention_flexion_behavior
  ]

  # 筋膜性腰痛ページの処理
  def myofascial_back_pain_extention_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      render 'pain_behavior_extention_flexion/intervertebral_joint_extention_flexion_behavior'
    else
      render 'diagnostic_result/myofascial_back_pain'
    end
  end

  # 椎間関節の処理
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
      render 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior'
    else
      render 'diagnostic_result/intervertebral_disk'
    end
  end

  # ニューテーションページの処理
  def nutation_extention_flexion_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      render 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior'
    else
      render 'diagnostic_result/nutation'
    end
  end

  # カウンターニューテーションページの処理
  class PainBehaviorExtentionFlexionController < ApplicationController
    # カウンターニューテーションページの処理
    def counternutation_extention_flexion_behavior
      conditions = params[:conditions] || []
  

  
      # 'nothing' が選ばれてかつ他の条件が選ばれていない場合のみ処理
      if conditions == ['nothing']

        render 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior'
      else

        render 'diagnostic_result/counternutation'
      end
    end
  end
  
  
end

