class SessionsController < ApplicationController
  before_action :verify_params, only: :create

  def create
    strava_athelete = StravaFacade.get_athlete(params[:code])
    
    user = User.find_or_create_by(strava_uid: strava_athelete.strava_uid)
    user.update(strava_athelete.athlete_info)
    user.update(username: strava_athelete.username) if user.username.nil?

    session[:user_id] = user.id
    session[:token] = strava_athelete.access_token

    redirect_to '/dashboard'
  end

  def destroy
    session.delete(:user_id)
    session.delete(:token)
    flash[:alert] = 'You have been successfully logged out'

    redirect_to '/'
  end

  private

  def verify_params
    redirect_to '/' unless params[:code]

    unless params[:scope] == 'read,activity:read_all'
      flash[:alert] = 'We need access in order to bank your brüs, ya fuck'
      redirect_to '/'
    end
  end
end
