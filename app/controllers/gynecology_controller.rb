class GynecologyController < ApplicationController
 
    def gynecology_question
    def submit_gynecology_question
      Rails.logger.debug "Params: #{params.inspect}" # デバッグ用のパラメータ表示
  
      if params[:no_specific_issue] == "1" # "特に問題なし" にチェックが入っている場合
        redirect_to red_flag_path # red_flag ページにリダイレクト
      else
        redirect_to orthopedics_advice_path # それ以外の場合は整形外科受診催促ページへ
      end
    end 
  end
end
  
  
  
  
  
  
