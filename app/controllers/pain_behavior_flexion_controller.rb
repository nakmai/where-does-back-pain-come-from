class PainBehaviorFlexionController < ApplicationController
    def pain_behavior_myofascial_back_pain
      conditions = params[:conditions] || []
      logger.debug("Conditions: #{conditions.inspect}")
  
      if conditions.include?('nothing')
        redirect_to pain_behavior_intervertebral_disk_path
      elsif conditions.include?('sitting_posture') || conditions.include?('parietal_flexion') || conditions.include?('rotation')
        redirect_to diagnostic_result_myofascial_back_pain_path
      else
        render 'pain_behavior_myofascial_back_pain/pain_behavior_myofascial_back_pain'
      end
    end
  
    def pain_behavior_intervertebral_disk
        conditions = params[:conditions] || []
        logger.debug("Conditions: #{conditions.inspect}")  # パラメータの内容を確認
      
        if conditions.include?('nothing')
          logger.debug("Redirecting to sacroiliac joint")
          redirect_to pain_behavior_sacroiliac_joint_path
        elsif conditions.include?('sitting_posture') || conditions.include?('massage') || conditions.include?('limbs')
          logger.debug("Redirecting to intervertebral disk result")  # このログが出力されるか確認
          redirect_to diagnostic_result_intervertebral_disk_path
        else
          logger.debug("Rendering intervertebral disk view")
          render 'pain_behavior_intervertebral_disk/pain_behavior_intervertebral_disk'
        end
      end
      

      def pain_behavior_sacroiliac_joint
        conditions = params[:conditions] || []
        logger.debug("Conditions: #{conditions.inspect}")  # ログでパラメータを確認
    
        if conditions.include?('nothing')
          # 「どれも当てはまらない」を選択した場合
          logger.debug("Redirecting to incontestable result")
          redirect_to diagnostic_result_incontestable_path
        elsif conditions.include?('standing_posture') || conditions.include?('sitting_posture') || conditions.include?('uncomfortable_feeling') || conditions.include?('limbs')
          # 条件に該当する場合、仙腸関節の結果にリダイレクト
          logger.debug("Redirecting to sacroiliac joint result")
          redirect_to diagnostic_result_sacroiliac_joint_path
        else
          # どの条件にも該当しない場合、再度フォームを表示
          logger.debug("Rendering sacroiliac joint form")
          render 'pain_behavior_sacroiliac_joint/pain_behavior_sacroiliac_joint'
        end
      end

      def incontestable
        render 'diagnostic_result/incontestable'
      end
    



end
  

  
  
  
  
  
  
  
  
  
