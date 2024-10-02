class DiagnosticResultController < ApplicationController
    def pain_behavior_myofascial_back_pain

          render 'diagnostic_result/myofascial_back_pain'
      end
    

      def pain_behavior_intervertebral_disk

          render 'diagnostic_result/intervertebral_disk'
      end

    
    def intervertebral_joint
        # ここに必要なロジックを追加します
        render 'diagnostic_result/intervertebral_joint'
      end

      def sacroiliac_joint
        conditions = params[:conditions] || []
        logger.debug("Conditions: #{conditions.inspect}")  # パラメータをログで確認
    
        if conditions.include?('nothing')
          # 「どれも当てはまらない」を選択した場合に myofascial_back_pain ページにリダイレクト
          logger.debug("Redirecting to myofascial back pain")
          redirect_to pain_behavior_myofascial_back_pain_path
        else
          # 他の条件に該当する場合に別のページにリダイレクト
          logger.debug("Rendering sacroiliac joint form")
          render 'diagnostic_result/sacroiliac_joint'
        end
      end

end
