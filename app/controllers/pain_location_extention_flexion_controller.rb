class PainLocationExtentionFlexionController < ApplicationController
  def extention_flexion
    render :pain_location_flexion
  end

  def submit_extention_flexion
    selected_pain_location = params[:pain_location_flexion][:pain_location]
    logger.debug("選択された痛みの場所: #{selected_pain_location}")

    case selected_pain_location
    when '腰の筋肉'
      # diagnostic_result_myofascial_back_pain ではなく、pain_behavior_myofascial_back_pain にリダイレクトする
      redirect_to pain_behavior_myofascial_back_pain_path
    when '背骨付近'
      redirect_to pain_behavior_intervertebral_joint_path
    when '腰骨の下(お尻のライン)'
      redirect_to pain_behavior_sacroiliac_joint_path
    else
      flash[:alert] = "選択してください。"
      render :pain_location_extention_flexion
    end
  end
end
  
