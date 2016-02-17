class DashboardController < ApplicationController
  def show
    @user_data = FitbitService.new(current_user).get_user_data
  end
end
