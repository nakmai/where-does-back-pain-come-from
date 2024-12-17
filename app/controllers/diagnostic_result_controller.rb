# frozen_string_literal: true

class DiagnosticResultController < ApplicationController
  def counternutation
    render 'diagnostic_result/counternutation'
  end

  def incontestable
    render 'diagnostic_result/incontestable'
  end
end
