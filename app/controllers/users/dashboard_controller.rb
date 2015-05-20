class Users::DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @days_left = current_user.subscription_days_left
  end
end