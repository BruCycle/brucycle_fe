class UserController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
  end

  def edit
    return redirect_to '/' unless current_user
  end

  def update 
    current_user.update(user_params)

    if params[:recipient] && BrucycleService.gift_beer(current_user.strava_uid, params[:recipient].to_i).status == 400
      flash[:alert] = 'You don\'t have enough brüs, ya fuck'
      redirect_to '/users'
    else
    redirect_to '/dashboard'
    end
  end

  private

  def user_params
    params.permit(:username, :email)
  end
end
