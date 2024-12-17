# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if user_signed_in?
      render :after_sign_in
    else
      render :index
    end
  end

  def after_sign_in; end

  def logout_complete; end
end
