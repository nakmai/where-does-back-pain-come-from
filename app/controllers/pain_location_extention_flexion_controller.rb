class PainLocationExtentionFlexionController < ApplicationController
    def extention_flexion
      if request.post?
        selected_pain_location = params[:pain_location_flexion][:pain_location]
  
        case selected_pain_location
        when '腰骨の外'
          redirect_to pain_behavior_myofascial_back_pain_path
        when '背骨付近'
          redirect_to pain_behavior_intervertebral_joint_path
        when '腰骨の下(お尻のライン)'
          redirect_to pain_behavior_sacroiliac_joint_path
        else
          flash[:alert] = "選択してください。"
          render :pain_location_extention_flexion  # 正しいテンプレート名を指定
        end
      else
        render :pain_location_extention_flexion  # 正しいテンプレート名を指定
      end
    end
  end
  
