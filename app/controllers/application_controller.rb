class ApplicationController < ActionController::Base
  def logged_in_user?
    !session[:user_id].nil?
  end

  # Function to block non-logged in users from accessing a page
  def authorized
    unless logged_in_user?
      flash[:alert] = "You must be logged in to access this page"
      #redirect_to whatever_login_page_is_defined_as
    end
  end
end
