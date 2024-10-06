class MyPageController < ApplicationController
    def my_page_myofascial_back_pain_guest
        # ゲストユーザーが表示できるビューをレンダリング
        render 'my_page/my_page_myofascial_back_pain'
      end

    def my_page_intervertebral_disk
        # 会員でもゲストでもアクセスできるアクション
        render 'my_page/my_page_intervertebral_disk'
    end

    def my_page_intervertebral_joint
      # ここで必要な処理を記述
      render 'my_page/my_page_intervertebral_joint'
    end

    def my_page_my_page_nutation
        # 会員でもゲストでもアクセスできるアクション
      render 'my_page/my_page_nutation'
    end
    
    def my_page_counternutation
      # 必要な処理をここに記述
      render 'my_page/my_page_counternutation'
    end
end
