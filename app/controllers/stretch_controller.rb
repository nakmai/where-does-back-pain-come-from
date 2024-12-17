# frozen_string_literal: true

class StretchController < ApplicationController
  def top
    render 'strech/top'
  end

  def adductor
    render 'strech/adductor'
  end

  def gluteus_maximus
    render 'strech/gluteus_maximus'
  end

  def hamstrings_towel
    render 'strech/hamstrings_towel'
  end

  def hamstrings
    render 'strech/hamstrings'
  end

  def psoas
    render 'strech/psoas'
  end

  def quadriceps_femoris
    render 'strech/quadriceps_femoris'
  end
end
