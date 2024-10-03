class PainBehaviorFlexionController < ApplicationController
  before_action :check_loop, only: [:myofascial_back_pain_flexion_behavior, :intervertebral_disk_flexion_behavior, :counternutation_flexion_behavior]
  
  # 椎間板ページの処理
  def intervertebral_disk_flexion_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      render 'pain_behavior_flexion/counternutation_flexion_behavior'
    else
      render 'diagnostic_result/intervertebral_disk'
    end
  end

  # カウンターニューテーションページの処理
  def counternutation_flexion_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      render 'pain_behavior_flexion/myofascial_back_pain_flexion_behavior'
    else
      render 'diagnostic_result/counternutation'
    end
  end

  # 筋膜性腰痛ページの処理
  def myofascial_back_pain_flexion_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      render 'pain_behavior_flexion/intervertebral_disk_flexion_behavior'
    else
      render 'diagnostic_result/myofascial_back_pain'
    end
  end

  def check_loop
    # セッションにページ訪問履歴を保持する
    session[:visited_pages] ||= []
    session[:visited_pages] << request.path

    # もし3つのページをすべて1巡したら強制的に `incontestable` にリダイレクト
    if session[:visited_pages].count(request.path) > 1
      session[:visited_pages] = []  # ループが発生したら履歴をリセット
      redirect_to diagnostic_result_incontestable_path and return
    end
  end
  
end