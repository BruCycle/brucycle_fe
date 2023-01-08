class UserController < ApplicationController
  def edit
    return redirect_to '/' unless current_user
  end

  def update 
    current_user.update(username: params[:username])
    
    redirect_to '/dashboard'
  end
end
