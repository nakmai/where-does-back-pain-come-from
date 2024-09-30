class PainLocationController < ApplicationController
    def flexion
        render 'pain_location/pain_location_flexion'
      end
  
    def extention
      render 'pain_location/pain_location/pain_location_extention'
    end
  
    def extention_flexion
      render 'pain_location/pain_location/pain_location_extention_flexion'
    end
  end
  
  
