class DashboardController < ApplicationController
  def index
    return redirect_to '/' unless current_user

    @user_stats = UserFacade.user(current_user.strava_uid, session[:token])
  end

  def update
    if current_user.last_beer && current_user.last_beer > (DateTime.now - 1.0 / 24)
      current_user.update(recent_beers: current_user.recent_beers + 1)
      if current_user.recent_beers > 4
        SafetyMailer.with(user: current_user).safety_email.deliver_now if current_user.email
        flash[:alert] = 'Our records indicate you might be inebriated, please take an Uber home'
      end
    else
      current_user.update(recent_beers: 1, last_beer: DateTime.now)
    end

    BrucycleService.drink_beer(current_user.strava_uid)
    redirect_to '/dashboard'
  end
end
