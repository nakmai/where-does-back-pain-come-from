class PainController < ApplicationController
  
  
  def red_flag
      # フォーム表示用アクション
      flash.clear
    end
  
    def submit_red_flag
      flash.clear
      conditions = params[:conditions] || []
    
      if conditions.include?('no_issues') && conditions.length == 1
        # 特に問題なしのみがチェックされている場合
        redirect_to red_flag2_path, notice: 
      else
        # 他の項目がチェックされている場合
        redirect_to orthopedics_advice2_path, notice:
      end
    end
  
    def red_flag2
      # red_flag2 ビューを表示
      flash.clear
    end
  
    def red_flag2_submit
        conditions = params[:conditions] || []
    
        if conditions.include?('no_issues')
          # 「特になし」が選択されている場合は pain_scale にリダイレクト
          redirect_to pain_scale_path
        else
          # それ以外の項目が選択されている場合は他のページにリダイレクト
          redirect_to orthopedics_advice3_path
        end
    end

    def red_flag2
      # red_flag2 ビューを表示
    end

    def pain_scale
      # 何もしない。ビューを表示するだけ。
    end

    def submit_pain_scale
      pain_level = params[:pain_level].to_i
    
      if pain_level >= 6
        redirect_to orthopedics_advice5_path
      else
        redirect_to achlorhydria_path
      end
    end

  def achlorhydria
    # 必要な処理をここに追加
  end
  
    def orthopedics_advice1
      # orthopedics_advice ビューを表示
    end
  
    def orthopedics_advice2
      # orthopedics_advice2 ビューを表示
    end

    def orthopedics_advice3
        # orthopedics_advice3 ビューを表示
    end

    def orthopedics_advice5
      # orthopedics_advice5 ビューを表示
    end 


    

  end
  
  
  
  
