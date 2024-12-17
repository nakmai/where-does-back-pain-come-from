# frozen_string_literal: true

class PainLocationFlexionController < ApplicationController
  def flexion
    render 'pain_location_flexion'
  end

  def counternutation_flexion_behavior; end

  def submit
    selected_location = params[:pain_location_flexion][:pain_location]

    case selected_location
    when '腰の筋肉'
      render 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior'
    when '背骨付近'
      render 'pain_behavior_flexion/intervertebral_disk_flexion_behavior'
    when '腰骨の下(お尻のライン)'
      render 'pain_behavior_flexion/nutation_flexion_behavior'
    else
      render 'root', alert: '無効な選択です。'
    end
  end
end
