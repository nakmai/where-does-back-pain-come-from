class PainBehaviorExtentionController < ApplicationController

  # 筋膜性腰痛ページの処理
  def myofascial_back_pain_extention_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      # 椎間関節のページに進む
      render 'pain_behavior_extention/intervertebral_joint_extention_behavior'
    else
      # 筋膜性腰痛の診断結果ページに進む
      render 'diagnostic_result/myofascial_back_pain'
    end
  end
  
  # 椎間関節の処理
  def intervertebral_joint_extention_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      # ニューテーションページに進む
      render 'pain_behavior_extention/nutation_extention_behavior'
    else
      # 椎間関節の診断結果ページに進む
      render 'diagnostic_result/intervertebral_joint'
    end
  end

  # ニューテーションページの処理
  def nutation_extention_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      # 筋膜性腰痛ページに戻る
      render 'pain_behavior_extention/myofascial_back_pain_extention_behavior'
    else
      # ニューテーションの診断結果ページに進む
      render 'diagnostic_result/nutation'
    end
  end
end


