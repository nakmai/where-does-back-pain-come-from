class PainLocationExtentionController < ApplicationController
    def extention
      render :pain_location_extention
    end

    def submit_extention
      pain_location = params[:pain_location_flexion][:pain_location]

      case pain_location
      when '腰の筋肉'
        redirect_to pain_behavior_myofascial_back_pain_path
      when '背骨付近'
        redirect_to pain_behavior_intervertebral_joint_path
      when '腰骨の下(お尻のライン)'
        redirect_to pain_behavior_sacroiliac_joint_path
      else
        flash[:alert] = "選択してください。"
        render :pain_location_extention
      end
    end
end
  
