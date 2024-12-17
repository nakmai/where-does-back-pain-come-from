# frozen_string_literal: true

class MuscleController < ApplicationController
  def top
    render 'muscle/top'
  end

  def adductor
    render 'muscle/adductor'
  end

  def erector_spinae
    render 'muscle/erector_spinae'
  end

  def gluteus_maximus
    render 'muscle/gluteus_maximus'
  end

  def hamstrings
    render 'muscle/hamstrings'
  end

  def polysaccharidic
    render 'muscle/polysaccharidic'
  end

  def psoas
    render 'muscle/psoas'
  end

  def quadriceps_femoris
    render 'muscle/quadriceps_femoris'
  end

  def rectus_abdominis
    render 'muscle/rectus_abdominis'
  end

  def transversus_abdominis
    render 'muscle/transversus_abdominis'
  end
end
