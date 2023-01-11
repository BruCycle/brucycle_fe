class DashboardController < ApplicationController
  before_action :check_for_user
  before_action :first_time_login, only: :index
  before_action :check_inebriation, only: :update

  def index
    UserFacade.get_activities(current_user.strava_uid, session[:token])
    @user_stats = UserFacade.user(current_user.strava_uid, session[:token])
  end

  def update
    UserFacade.drink_beer(current_user.strava_uid)
    redirect_to '/dashboard'
  end

  private

  def check_for_user
    redirect_to '/' unless current_user
  end

  def check_inebriation
    if current_user.inebriated?
      SafetyMailer.with(user: current_user).safety_email.deliver_now if current_user.email
      flash[:alert] = 'Our records indicate you might be inebriated, please take an Uber home'
    end
  end

  def first_time_login
    UserFacade.user(current_user.strava_uid, session[:token]) if current_user.created_at > DateTime.now - 1.0/24
  end
end
