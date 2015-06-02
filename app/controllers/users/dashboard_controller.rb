class Users::DashboardController < ApplicationController
  before_filter :authenticate_user!

  # Renders User dashboard page
  # @days_left returns number of days until the end of subscription
  # GET /users/dashboard
  def index
    @days_left = current_user.subscription_days_left
  end
end