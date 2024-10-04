class PainBehaviorExtentionFlexionController < ApplicationController
  before_action :check_loop, only: [:myofascial_back_pain_extention_flexion_behavior, 
                                    :intervertebral_joint_extention_flexion_behavior, 
                                    :intervertebral_disk_extention_flexion_behavior, 
                                    :nutation_extention_flexion_behavior, 
                                    :counternutation_extention_flexion_behavior]

  # 筋膜性腰痛ページの処理
  def myofascial_back_pain_extention_flexion_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      render 'pain_behavior_extention_flexion/intervertebral_joint_extention_flexion_behavior'
    else
      render 'diagnostic_result/myofascial_back_pain'
    end
  end

  # 椎間関節の処理
  def intervertebral_joint_extention_flexion_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      render 'pain_behavior_extention_flexion/intervertebral_disk_extention_flexion_behavior'
    else
      render 'diagnostic_result/intervertebral_joint'
    end
  end

  # 椎間板ページの処理
  def intervertebral_disk_extention_flexion_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      render 'pain_behavior_extention_flexion/nutation_extention_flexion_behavior'
    else
      render 'diagnostic_result/intervertebral_disk'
    end
  end

  # ニューテーションページの処理
  def nutation_extention_flexion_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      render 'pain_behavior_extention_flexion/counternutation_extention_flexion_behavior'
    else
      render 'diagnostic_result/nutation'
    end
  end

  # カウンターニューテーションページの処理
  def counternutation_extention_flexion_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      render 'pain_behavior_extention_flexion/myofascial_back_pain_extention_flexion_behavior'
    else
      render 'diagnostic_result/counternutation'
    end
  end

  # ループをチェックしてリダイレクトするメソッド
  def check_loop
    session[:visited_pages] ||= []  # 訪問したページの履歴をセッションに保存
    session[:visited_pages] << request.path

    # 各ページが1巡したかをチェック（全ページを1回以上訪問したらリセット）
    if session[:visited_pages].count(request.path) > 1
      session[:visited_pages] = []  # ループが発生したら履歴をリセット
      redirect_to diagnostic_result_incontestable_path and return
    end
  end
end

