class PainBehaviorExtentionController < ApplicationController
  # `unknown_extention_behavior` アクションを `check_nothing_selections` フィルターの適用から除外
  before_action :check_nothing_selections, except: :unknown_extention_behavior

  # ループ防止用の閾値
  MAX_NOTHING_SELECTIONS = 7

  # 「特になし」が選択された回数を確認し、一定回数以上なら unknown_extention_behavior ビューへリダイレクト
  def check_nothing_selections
    session[:nothing_selections] ||= 0
    if session[:nothing_selections] >= MAX_NOTHING_SELECTIONS
      redirect_to pain_behavior_extention_unknown_extention_behavior_path and return
    end
  end

  # 筋膜性腰痛ページの処理
  def myofascial_back_pain_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention/intervertebral_joint_extention_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/myofascial_back_pain'
    end
  end

  # 椎間関節ページの処理
  def intervertebral_joint_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention/nutation_extention_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/intervertebral_joint'
    end
  end

  # ニューテーションページの処理
  def nutation_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention/counternutation_extention_behavior' 
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/nutation'
    end
  end

  # カウンターニューテーションページの処理
  def counternutation_extention_behavior
    conditions = params[:conditions] || []
    if conditions.include?('nothing')
      session[:nothing_selections] += 1
      render 'pain_behavior_extention/myofascial_back_pain_extention_behavior'
    else
      session[:nothing_selections] = 0
      render 'diagnostic_result/counternutation'
    end
  end

  # unknown_extention_behavior のアクション
  def unknown_extention_behavior
    reset_session # セッションをリセットしてループを防ぐ
    render 'pain_behavior_extention/unknown_extention_behavior'
  end

end
