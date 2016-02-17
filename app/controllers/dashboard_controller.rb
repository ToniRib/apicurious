class DashboardController < ApplicationController
  def show
    @user_data = FitbitService.new(current_user).get_user_data
    # @friends = fitbit_service.get_friends
    # @sleep = fitbit_service.get_sleep
    # resting_heartrate = fitbit_service.get_resting_heartrate
    # @heartrate_data = resting_heartrate.map { |entry| entry[:heart_rate] }
  end
end
