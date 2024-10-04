class PainLocationFlexionController < ApplicationController
  def flexion
    # ビューをレンダリングするだけの場合
    render 'pain_location_flexion'
  end


  def counternutation_flexion_behavior
    # リダイレクト処理があるか確認
    # redirect_to xxx がある場合、意図したURLにリダイレクトされているか確認

  end
  
  def submit
    selected_location = params[:pain_location_flexion][:pain_location]

    case selected_location
    when '腰の筋肉'
      # ビューを直接レンダリングして確認
      render 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior'
    when '背骨付近'
      # ビューを直接レンダリングして確認
      render 'pain_behavior_flexion/intervertebral_disk_flexion_behavior'
    when '腰骨の下(お尻のライン)'
      # ビューを直接レンダリングして確認
      render 'pain_behavior_flexion/counternutation_flexion_behavior'
    else
      redirect_to root_path, alert: '無効な選択です。'
    end
  end
end




  
  
