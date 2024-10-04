class PainBehaviorFlexionController < ApplicationController
    # 筋膜性腰痛ページの処理
    def myofascial_back_pain_flexion_behavior
      conditions = params[:conditions] || []
      Rails.logger.debug "Conditions: #{conditions}"
  
      if conditions.include?('nothing')
        # 椎間板のページをレンダリング
        render 'pain_behavior_flexion/intervertebral_disk_flexion_behavior'
      else
        # 筋膜性腰痛の診断結果ページをレンダリング
        render 'diagnostic_result/myofascial_back_pain'
      end
    end
  
    # 椎間板ページの処理
    def intervertebral_disk_flexion_behavior
      selected_conditions = params[:conditions] || []
  
      if selected_conditions.include?('nothing')
        # "nothing" が選択された場合、カウンターニューテーションページをレンダリング
        render 'pain_behavior_flexion/counternutation_flexion_behavior'
      else
        # 他の選択肢に応じて筋膜性腰痛ページをレンダリング
        render 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior'
      end
    end
  
    # カウンターニューテーションページの処理
    def counternutation_flexion_behavior
      conditions = params[:conditions] || []
  
      if conditions.include?('nothing')
        # 筋膜性腰痛ページをレンダリング
        render 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior'
      else
        # カウンターニューテーションの診断結果ページをレンダリング
        render 'diagnostic_result/counternutation'
      end
    end
  end
  