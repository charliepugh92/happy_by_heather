class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_current_user
  before_action :authenticate!

  private

  def find_current_user
    @current_user = User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def authenticate!
    redirect_to login_path unless login_valid?
  end

  protected

  def login_valid?
    cookies.signed[:user_id] && @current_user && BCrypt::Password.new(@current_user.remember_digest) == cookies.signed[:remember_token]
  end
end
