class ActivitiesController < ApplicationController
  def index
    @activities = UserFacade.get_activities(current_user.strava_id, session[:token])
  end
end 