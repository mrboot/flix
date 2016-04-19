class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types(:danger)

  private

  # checks if the user is logged in and if not redirects to the login page.
  def require_signin
    unless current_user
      # store the url used before hitting this method
      session[:intended_url] = request.url
      redirect_to signin_url, alert: "Please sign in first!"
    end
  end

  # moved from ApplicationHelper so it can be used in the require_signin method above
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # added to that it can still be used as a view helper method
  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

end
