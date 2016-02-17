class DashboardController < ApplicationController
  def show
    fitbit_service = FitbitService.new(current_user)
    @friends = fitbit_service.get_friends
    @sleep = fitbit_service.get_sleep
  end
end
