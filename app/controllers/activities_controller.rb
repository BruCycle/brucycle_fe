class ActivitiesController < ApplicationController
  def index
    return redirect_to '/' unless current_user
    
    @activities = UserFacade.get_activities(current_user.strava_uid, session[:token])
  end
end 