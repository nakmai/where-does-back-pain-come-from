class GynecologyController < ApplicationController

    def gynecology_question
      # gynecology_questionページを表示するアクション
    end
  
    def submit_gynecology_question
      # チェックボックスのパラメータを取得
      no_specific_issue = params[:no_specific_issue] == '1'
      pregnancy = params[:pregnancy] == '1'
      strong_menstrual_pain = params[:strong_menstrual_pain] == '1'
      calorie_intake = params[:calorie_intake] == '1'
      menstrual_irregularity = params[:menstrual_irregularity] == '1'
  
      # 条件に基づいてリダイレクト
      if no_specific_issue
        # 「特になし」が選択されている場合、レッドフラッグページにリダイレクト
        redirect_to red_flag_path
      else
        # それ以外が選択されている場合、婦人科アドバイスページにリダイレクト
        redirect_to gynecology_advice_path
      end
    end
  end
  
