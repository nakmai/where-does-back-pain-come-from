# frozen_string_literal: true

class MyofascialBackPainFlexionBehaviorController < ApplicationController
  def my_page_myofascial_back_pain
    @user = User.find(params[:id])
    render 'my_page/my_page_myofascial_back_pain'
  end
end
