class DashboardController < ApplicationController
  def index
    @user_stats = UserFacade.user(current_user.strava_id)
    
  end
end