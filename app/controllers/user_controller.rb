class UserController < ApplicationController
  def edit; end

  def update 
    current_user.update(username: params[:username])
    
    redirect_to '/dashboard'
  end
end
