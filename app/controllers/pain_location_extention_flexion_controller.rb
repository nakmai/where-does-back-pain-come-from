class PainLocationExtentionFlexionController < ApplicationController
  def extention_flexion
    render 'pain_location_extention_flexion/pain_location_extention_flexion'
  end
  
  def submit
    pain_location = params[:pain_location_flexion][:pain_location]
    case pain_location
    when '腰の筋肉'
      render 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior'
    when '背骨付近'
      render 'pain_behavior_extention_flexion/intervertebral_joint_extention_flexion_behavior'
    when '腰骨の下(お尻のライン)'
      render 'pain_behavior_extention_flexion/nutation_extention_flexion_behavior'
    else
      flash[:alert] = "正しい痛みの部位を選択してください"
      render :pain_location_extention_flexion 
    end
  end
end

  
  
