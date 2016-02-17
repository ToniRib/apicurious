class DashboardController < ApplicationController
  def show
    fitbit_service = FitbitService.new
    @friends ||= fitbit_service.get_friends(current_user)
  end
end
