class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :authorized

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end
  # Function to block non-logged in users from accessing a page
  def authorized
    unless logged_in?
      flash[:alert] = "You must be logged in to access this page"
      #redirect_to whatever_login_page_is_defined_as
    end
  end
end