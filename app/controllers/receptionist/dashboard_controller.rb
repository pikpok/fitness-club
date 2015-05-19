class Receptionist::DashboardController < ApplicationController
  before_filter :authenticate_receptionist!

  def index
  end
end
