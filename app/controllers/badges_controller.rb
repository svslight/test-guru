class BadgesController < ApplicationController

  before_action :authenticate_user!

  def index
    @badges = Badge.all
  end

  def show
    # массив полученных наград пользователя
    @user_badges = Badge.user_badges(current_user)
  end
end
