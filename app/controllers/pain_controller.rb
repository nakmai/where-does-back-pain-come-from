class PainController < ApplicationController
    def red_flag
      # フォーム表示用アクション
    end
  
    def submit_red_flag
      conditions = params[:conditions] || []
  
      if conditions.include?('no_issues') && conditions.length == 1
        # 特に問題なしのみがチェックされている場合
        redirect_to red_flag2_path
      else
        # 他の項目がチェックされている場合
        redirect_to orthopedics_advice_path
      end
    end
  
    def red_flag2
      # red_flag2 ビューを表示
    end
  
    def red_flag2_submit
        conditions = params[:conditions] || []
    
        if conditions.include?('no_issues')
          # 「特になし」が選択されている場合は pain_scale にリダイレクト
          redirect_to pain_scale_path
        else
          # それ以外の項目が選択されている場合は他のページにリダイレクト
          redirect_to orthopedics_advice2_path
        end
    end
  
    def orthopedics_advice
      # orthopedics_advice ビューを表示
    end
  
    def orthopedics_advice2
      # orthopedics_advice2 ビューを表示
    end
  end
  
  
  
  
