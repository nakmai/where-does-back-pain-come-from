class MyPageController < ApplicationController
  def myofascial_back_pain_guest
    render 'users/guest/myofascial_back_pain'
  end

  def intervertebral_disk_guest
    # このアクション内に処理を記述してください
    render 'users/guest/intervertebral_disk'
  end

  def nutation_guest
    # 必要であれば、ここで必要な処理を行う
    render 'users/guest/nutation'  # ゲスト向けのテンプレートを表示
  end

  def counternutation_guest
    # 必要であれば、ここで必要な処理を行う
    render 'users/guest/counternutation'  # ゲスト向けのテンプレートを表示
  end

  def intervertebral_joint_guest
    render 'users/guest/intervertebral_joint'
  end

  def myofascial_back_pain_user
    user_id = params[:user_id]  # user_idを取得
    @user = User.find(user_id)
    render 'users/user/myofascial_back_pain'
  end

  def intervertebral_joint_user
    user_id = params[:user_id]
    # 必要な処理を追加
    render 'users/user/myofascial_back_pain'  # 遷移先のビューを指定
  end
end
