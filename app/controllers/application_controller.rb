class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :check_expiration

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def check_expiration
    if current_user && DateTime.now >= expiry
      session[:expiration] = DateTime.now + 3600.seconds if current_user.renew_token
    end
  end

  def expiry
    session[:expiration]
  end
end
