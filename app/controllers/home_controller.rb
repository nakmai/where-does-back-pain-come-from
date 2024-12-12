# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # ホームページの処理
    if user_signed_in?
      render :after_sign_in # ログイン済みの場合は after_sign_in ビューを表示
    else
      render :index # 未ログインの場合は通常の index ビューを表示
    end
  end

  def after_sign_in
    # ログイン後に表示する処理
  end

  def logout_complete
    # ログアウト完了ページの処理
  end
end
