class UserController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
  end

  def edit
    return redirect_to '/' unless current_user
  end

  def update
    if params[:username]
      current_user.update(username: params[:username])
    end
    redirect_to '/dashboard'
  end
end
