class DashboardController < ApplicationController
  def show
    fitbit_service = FitbitService.new(current_user)
    @friends = fitbit_service.get_friends
    @sleep = fitbit_service.get_sleep
    resting_heartrate = fitbit_service.get_resting_heartrate
    @heartrate_data = resting_heartrate.map { |entry| entry[:heart_rate] }
  end
end
