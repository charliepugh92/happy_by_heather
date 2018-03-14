class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate!

  private

  def authenticate!
    @current_user = User.find(session[:user_id]) if session[:user_id]
    redirect_to login_path unless session[:user_id] && @current_user
  end
end
