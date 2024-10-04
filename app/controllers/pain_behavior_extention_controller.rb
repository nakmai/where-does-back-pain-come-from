class PainBehaviorExtentionController < ApplicationController
  before_action :check_loop, only: [:myofascial_back_pain_extention_behavior, 
                                    :intervertebral_joint_extention_behavior, 
                                    :nutation_extention_behavior]

  # 筋膜性腰痛ページの処理
  def myofascial_back_pain_extention_behavior
    conditions = params[:conditions] || []
    
    # セッションでサイクルを管理
    session[:cycle_count] ||= 0

    if conditions.include?('nothing')
      session[:cycle_count] += 1
      if session[:cycle_count] > 1
        session[:cycle_count] = 0
        render 'pain_behavior_extention/myofascial_back_pain_extention_behavior'
      else
        render 'pain_behavior_extention/intervertebral_joint_extention_behavior'
      end
    else
      session[:cycle_count] = 0
      render 'diagnostic_result/myofascial_back_pain'
    end
  end
  
  # 椎間関節の処理
  def intervertebral_joint_extention_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      render 'pain_behavior_extention/nutation_extention_behavior'
    else
      render 'diagnostic_result/intervertebral_joint'
    end
  end

  # ニューテーションページの処理
  def nutation_extention_behavior
    conditions = params[:conditions] || []

    if conditions.include?('nothing')
      render 'pain_behavior_extention/myofascial_back_pain_extention_behavior'
    else
      render 'diagnostic_result/nutation'
    end
  end

  private

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





  



