class UserController < ApplicationController
  def edit
    return redirect_to '/' unless current_user
  end

  def update 
    current_user.update(user_params)
    
    redirect_to '/dashboard'
  end

  private

  def user_params
    params.permit(:username, :email)
  end
end
