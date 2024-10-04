class DiagnosisController < ApplicationController
  def create
    pain_type = params[:pain_type]
    Rails.logger.debug("Received pain_type: #{pain_type}")

    case pain_type
    when '腰を曲げても反っても痛い'
      redirect_to pain_location_extention_flexion_path
    when '腰を反ると痛い', '腰を反って捻ると痛い'
      redirect_to pain_location_extention_path
    when '腰を曲げると痛い', '腰を反って曲げると痛い'
      redirect_to pain_location_flexion_path
    else
      flash.now[:alert] = '1つ選択をしてください'
      render 'diagnosis/achlorhydria'
    end
  end

  def show
    @diagnosis = Diagnosis.find(params[:id])
  end

  def achlorhydria
    # 必要な処理をここに記述
    # 例: head :no_content や render 'diagnosis/achlorhydria'
    render 'diagnosis/achlorhydria' # 対応するビューを表示させる場合
  end
  
end





