class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Devise::Controllers::Helpers

  INCOMING_REQUESTS = [
  ]

  before_filter :require_login, except: INCOMING_REQUESTS

	def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to log_in_url
    end
  end
end
