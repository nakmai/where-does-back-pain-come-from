class MuscleController < ApplicationController
  # トップページに関連するロジック
  def top
    # "top.html.erb" ビューをレンダリング
    render 'muscle/top'
  end

  # adductorに関連するロジック
  def adductor
    # "adductor.html.erb" ビューをレンダリング
    render 'muscle/adductor'
  end

  # erector_spinaeに関連するロジック
  def erector_spinae
    # "erector_spinae.html.erb" ビューをレンダリング
    render 'muscle/erector_spinae'
  end

  # gluteus_maximusに関連するロジック
  def gluteus_maximus
    # "gluteus_maximus.html.erb" ビューをレンダリング
    render 'muscle/gluteus_maximus'
  end

  # hamstringsに関連するロジック
  def hamstrings
    # "hamstrings.html.erb" ビューをレンダリング
    render 'muscle/hamstrings'
  end

  # polysaccharidicに関連するロジック
  def polysaccharidic
    # "polysaccharidic.html.erb" ビューをレンダリング
    render 'muscle/polysaccharidic'
  end

  # psoasに関連するロジック
  def psoas
    # "psoas.html.erb" ビューをレンダリング
    render 'muscle/psoas'
  end

  # quadriceps_femorisに関連するロジック
  def quadriceps_femoris
    # "quadriceps_femoris.html.erb" ビューをレンダリング
    render 'muscle/quadriceps_femoris'
  end

  # rectus_abdominisに関連するロジック
  def rectus_abdominis
    # "rectus_abdominis.html.erb" ビューをレンダリング
    render 'muscle/rectus_abdominis'
  end

  # transversus_abdominisに関連するロジック
  def transversus_abdominis
    # "transversus_abdominis.html.erb" ビューをレンダリング
    render 'muscle/transversus_abdominis'
  end
end
