class GynecologyController < ApplicationController
  def gynecology_question
    # フォーム表示用のアクション
  end

  def submit_gynecology_question
    # パラメータが配列で送信されることを想定
    if params[:conditions]&.include?('no_specific_issue') # "特に問題なし" にチェックが入っている場合
      redirect_to red_flag_path # red_flag ページにリダイレクト
    else
      redirect_to gynecology_advice_path # それ以外の場合は婦人科受診催促ページへ
    end
  end

  def gynecology_advice
    # フォーム表示用のアクション
  end
end
