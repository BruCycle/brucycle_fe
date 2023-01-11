class DashboardController < ApplicationController
  before_action :check_for_user

  def index
    UserFacade.user(current_user.strava_uid, session[:token])
    UserFacade.get_activities(current_user.strava_uid, session[:token])
    @user_stats = UserFacade.user(current_user.strava_uid, session[:token])
  end

  def update
    if current_user.inebriated?
      SafetyMailer.with(user: current_user).safety_email.deliver_now if current_user.email
      flash[:alert] = 'Our records indicate you might be inebriated, please take an Uber home'
    end

    UserFacade.drink_beer(current_user.strava_uid)
    redirect_to '/dashboard'
  end

  private

  def check_for_user
    redirect_to '/' unless current_user
  end
end
