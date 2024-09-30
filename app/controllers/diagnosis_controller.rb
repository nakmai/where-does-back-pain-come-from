class DiagnosisController < ApplicationController
  def  extention

  end

  def flextion
  
  end

  def extention_flexion
  
  end

  def create
    pain_types = params[:pain_type] || []
      if (pain_types.include?('腰を反ると痛い') || pain_types.include?('腰を反って捻ると痛い'))
        redirect_to extention_path
      elsif (pain_types.include?('腰を曲げると痛い') || pain_types.include?('腰を反って曲げると痛い'))
        redirect_to flexion_path
      elsif pain_types.include?('腰を曲げても反っても痛い')
        redirect_to extention_flexion_path
      else
        redirect_to diagnosis_path, alert: '症状を選択してください'
      end
  end

end
