class UserController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
  end

  def edit
    return redirect_to '/' unless current_user
  end

  def update
    current_user.update(username: params[:username]) if params[:username]
    
    if params[:recipient] && BrucycleService.gift_beer(current_user.strava_uid, params[:recipient].to_i).body.include?('errors')
      flash[:alert] = 'You don\'t have enough brüs, ya fuck'
      redirect_to '/users'
    else
      redirect_to '/dashboard'
    end
  end
end
