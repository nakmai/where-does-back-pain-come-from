class GynecologyController < ApplicationController
  def gynecology_question
    # フォーム表示用のアクション
  end

  def submit_gynecology_question
<<<<<<< HEAD
    conditions = params[:conditions] || []

    # チェックボックスが選択されていない場合
    if conditions.empty?
      flash.now[:alert] = '選択してください'
      @conditions = conditions
      render :gynecology_question
      return
    end

    # 「特に問題なし」と他の選択肢が両方選ばれている場合
    if conditions.include?('no_specific_issue') && conditions.size > 1
      flash.now[:alert] = '無効な選択です'
      @conditions = conditions
      render :gynecology_question
      return
    end

    # チェックされた条件に基づきリダイレクト
    if conditions.include?('no_specific_issue')
      redirect_to red_flag_path # '特に問題なし' にチェックが入っている場合
=======
    # パラメータが配列で送信されることを想定
    if params[:conditions]&.include?('no_specific_issue') # "特に問題なし" にチェックが入っている場合
      redirect_to red_flag_path # red_flag ページにリダイレクト
>>>>>>> d83ee46f6a74ffc7cff9ee3271ce5b3b2faeafbd
    else
      redirect_to gynecology_advice_path # それ以外の場合は婦人科受診催促ページへ
    end
  end

  def gynecology_advice
<<<<<<< HEAD
    # 婦人科受診催促ページ用のアクション
  end
end

=======
    # フォーム表示用のアクション
  end
end
>>>>>>> d83ee46f6a74ffc7cff9ee3271ce5b3b2faeafbd
