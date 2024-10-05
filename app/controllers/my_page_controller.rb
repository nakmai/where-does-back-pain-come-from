class MyPageController < ApplicationController
    def my_page_myofascial_back_pain_guest
        # ゲストユーザーが表示できるビューをレンダリング
        render 'my_page/my_page_myofascial_back_pain'
      end
end
