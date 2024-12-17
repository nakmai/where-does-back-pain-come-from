# frozen_string_literal: true

class PainLocationExtentionController < ApplicationController
  def extention
    render 'pain_location_extention'
  end

  def submit
    selected_location = params[:pain_location_extention][:pain_location]

    case selected_location
    when '腰の筋肉'
      render 'pain_behavior_extention/myofascial_back_pain_extention_behavior'
    when '背骨付近'
      render 'pain_behavior_extention/intervertebral_joint_extention_behavior'
    when '腰骨の下(お尻のライン)'
      render 'pain_behavior_extention/nutation_extention_behavior'
    else
      redirect_to root_path, alert: '無効な選択です。'
    end
  end
end
