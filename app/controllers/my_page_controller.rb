# frozen_string_literal: true

class MyPageController < ApplicationController
  def myofascial_back_pain_guest
    render 'users/guest/myofascial_back_pain'
  end

  def intervertebral_disk_guest
    render 'users/guest/intervertebral_disk'
  end

  def nutation_guest
    render 'users/guest/nutation'
  end

  def counternutation_guest
    render 'users/guest/counternutation'
  end

  def intervertebral_joint_guest
    render 'users/guest/intervertebral_joint'
  end

  def new_guest_intervertebral_joint
    render 'users/guest/intervertebral_joint'
  end

  def myofascial_back_pain
    @user = User.find(params[:id])
    render 'users/myofascial_back_pain'
  end

  def intervertebral_joint_user
    params[:user_id]
    render 'users/user/intervertebral_joint'
  end
end
