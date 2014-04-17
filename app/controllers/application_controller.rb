class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_diver
    @current_diver ||= Diver.find(session[:diver_id]) if session[:diver_id]
  end
  helper_method :current_diver

  def logged_in?
  	!!current_diver
  end
  helper_method :logged_in?

  def authorized_diver?(dive)
    logged_in? && dive.divers.include?(current_diver)
  end
  helper_method :authorized_diver?  

end
