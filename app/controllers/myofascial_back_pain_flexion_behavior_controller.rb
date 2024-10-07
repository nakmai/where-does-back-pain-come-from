class MyofascialBackPainFlexionBehaviorController < ApplicationController
    def my_page_myofascial_back_pain
        @user = User.find(params[:id])
        # 他に必要なデータもここで取得
    
        # ビューを明示的に指定する
        render 'my_page/my_page_myofascial_back_pain'
    end
end