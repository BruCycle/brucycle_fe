class DashboardController < ApplicationController
  def index
    return redirect_to '/' unless current_user
    
    @user_stats = UserFacade.user(current_user.strava_id, session[:token])
  end

  def update
    BrucycleService.drink_beer(current_user.strava_id)
    redirect_to '/dashboard'
  end
end
