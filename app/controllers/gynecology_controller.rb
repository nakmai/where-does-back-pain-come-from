# frozen_string_literal: true

class GynecologyController < ApplicationController
  def gynecology_question; end

  def submit_gynecology_question
    conditions = params[:conditions] || []

    if conditions.empty?
      flash.now[:alert] = '選択してください'
      @conditions = conditions
      render :gynecology_question
      return
    end

    if conditions.include?('no_specific_issue') && conditions.size > 1
      flash.now[:alert] = '無効な選択です'
      @conditions = conditions
      render :gynecology_question
      return
    end

    if conditions.include?('no_specific_issue')
      redirect_to red_flag_path
    else
      redirect_to gynecology_advice_path
    end
  end

  def gynecology_advice; end
end
