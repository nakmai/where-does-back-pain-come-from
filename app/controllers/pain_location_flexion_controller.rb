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
      # '腰の筋肉'が選択された場合、該当するビューをレンダリング
      render 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior'
    when '背骨付近'
      # '背骨付近'が選択された場合、該当するビューをレンダリング
      render 'pain_behavior_flexion/intervertebral_disk_flexion_behavior'
    when '腰骨の下(お尻のライン)'
      # '腰骨の下(お尻のライン)'が選択された場合、該当するビューをレンダリング
      render 'pain_behavior_flexion/nutation_flexion_behavior'
    else
      # 無効な選択があった場合、ルートページに戻る
      render 'root', alert: '無効な選択です。'
    end
  end
end
