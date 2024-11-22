class StretchController < ApplicationController
  # トップページに関連するロジック
  def top
    render 'strech/top'
  end

  # adductorに関連するロジック
  def adductor
    render 'strech/adductor'
  end

  # gluteus_maximusに関連するロジック
  def gluteus_maximus
    render 'strech/gluteus_maximus'
  end

  # hamstrings_towelに関連するロジック
  def hamstrings_towel
    render 'strech/hamstrings_towel'
  end

  # hamstringsに関連するロジック
  def hamstrings
    render 'strech/hamstrings'
  end

  # psoasに関連するロジック
  def psoas
    render 'strech/psoas'
  end

  # quadriceps_femorisに関連するロジック
  def quadriceps_femoris
    render 'strech/quadriceps_femoris'
  end
end
