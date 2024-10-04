class PainLocationExtentionController < ApplicationController
  def extention
    # ビューをレンダリングするだけの場合
    render 'pain_location_extention'
  end

  def submit
    selected_location = params[:pain_location_extention][:pain_location]
  
      case selected_location
      when '腰の筋肉'
        # 直接ビューを表示する
        render 'pain_behavior_extention/myofascial_back_pain_extention_behavior'
      when '背骨付近'
        # 直接ビューを表示する
        render 'pain_behavior_extention/intervertebral_joint_extention_behavior'
      when '腰骨の下(お尻のライン)'
        # 直接ビューを表示する
        render 'pain_behavior_extention/nutation_extention_behavior'
      else
        # 無効な選択だった場合にホームにリダイレクト
        redirect_to root_path, alert: '無効な選択です。'
      end
  end
end





  
