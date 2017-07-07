class SessionsController < ApplicationController
  def create
    user = RedditService.sign_in(params["code"])

    if user.save
      session[:user_id] = user.id
      session[:expiration] = DateTime.now + 3600.seconds
    end

    redirect_to root_path
  end

  def destroy
    session.clear
    flash[:success] = 'Successfully logged out!'
    redirect_to root_path
  end
end
