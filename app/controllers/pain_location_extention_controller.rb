class PainLocationExtentionController < ApplicationController
    def extention
      selected_pain_location = params[:pain_location]
  
      case selected_pain_location
      when '腰骨の外'
        # 筋肉が原因の痛みの場合
        redirect_to pain_behavior_myofascial_back_pain_path
      when '腰の中心'
        # 椎間関節の痛みの場合
        redirect_to pain_behavior_intervertebral_joint_path
      when '腰骨の下(お尻のライン)'
        # 仙腸関節の痛みの場合
        redirect_to pain_behavior_sacroiliac_joint_path
      else
        flash[:alert] = "選択してください。"
        render :pain_location_extention
      end
    end
  end
  
