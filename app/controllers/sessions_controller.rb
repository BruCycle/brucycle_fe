class SessionsController < ApplicationController
  def create
    return redirect_to '/' unless params[:code]

    if params[:scope] != "read,activity:read_all"
      flash[:alert] = 'We need access in order to bank your brüs, you fuck'
      return redirect_to '/'
    end

    data = StravaService.get_athlete_data(params[:code])
  
    user = User.find_or_create_by(strava_uid: data[:athlete][:id])

    user.update(photo_url: data[:athlete][:profile],
                firstname: data[:athlete][:firstname],
                lastname: data[:athlete][:lastname])

    user.update(username: data[:athlete][:username]) if user.username.nil?

    session[:user_id] = user.id
    session[:token] = data[:access_token]
    
    redirect_to '/dashboard'
  end

  def destroy
    session.delete(:user_id)
    session.delete(:token)
    flash[:alert] = 'You have been successfully logged out'

    redirect_to '/'
  end
end
