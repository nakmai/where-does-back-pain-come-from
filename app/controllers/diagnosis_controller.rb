class DiagnosisController < ApplicationController
  def create
    pain_type = params[:pain_type]
  
    case pain_type
    when '腰を曲げても反っても痛い'
      redirect_to pain_location_extention_flexion_diagnosis_index_path and return
    when '腰を反ると痛い', '腰を反って捻ると痛い'
      redirect_to pain_location_extention_path and return
    when '腰を曲げると痛い', '腰を反って曲げると痛い'
      redirect_to pain_location_flexion_diagnosis_index_path and return
    else
      redirect_to achlorhydria_path, alert: '痛みのタイプを選択してください'
    end
  end
end



