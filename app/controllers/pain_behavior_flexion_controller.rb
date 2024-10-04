class PainBehaviorFlexionController < ApplicationController
    # 筋膜性腰痛ページの処理
    def myofascial_back_pain_flexion_behavior
      conditions = params[:conditions] || []
      Rails.logger.debug "Conditions: #{conditions}"
  
      if conditions.include?('nothing')
        # 椎間板のページに進む
        render 'pain_behavior_flexion/intervertebral_disk_flexion_behavior'
      else
        # 筋膜性腰痛の診断結果ページに進む
        render 'diagnostic_result/myofascial_back_pain'
      end
    end
  
    # 椎間板の処理
    def intervertebral_disk_flexion_behavior
      conditions = params[:conditions] || []
  
      if conditions.include?('nothing')
        # カウンターニューテーションのページに進む
        render 'pain_behavior_flexion/counternutation_flexion_behavior'
      else
        # 椎間板の診断結果ページに進む
        render 'diagnostic_result/intervertebral_disk'
      end
    end
  
    # カウンターニューテーションページの処理
    def counternutation_flexion_behavior
      conditions = params[:conditions] || []
  
      if conditions.include?('nothing')
        # 筋膜性腰痛ページに戻る
        render 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior'
      else
        # カウンターニューテーションの診断結果ページに進む
        render 'diagnostic_result/counternutation'
      end
    end
  end
  