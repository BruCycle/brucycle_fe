class DashboardController < ApplicationController
  def index
    return redirect_to '/' unless current_user
    UserFacade.user(current_user.strava_uid, session[:token])
    UserFacade.get_activities(current_user.strava_uid, session[:token])
    @user_stats = UserFacade.user(current_user.strava_uid, session[:token])
  end

  def update
    BrucycleService.drink_beer(current_user.strava_uid)
    redirect_to '/dashboard'
  end
end
