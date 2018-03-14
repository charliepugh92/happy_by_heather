class SessionsController < ApplicationController
  skip_before_action :authenticate!
  before_action :authenticate!, only: [:destroy]
  before_action :create_params, only: [:create]

  def new
    redirect_to root_path if login_valid?
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      user.remember
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent.signed[:remember_token] = user.remember_token

      redirect_to root_path
    else
      flash.now[:danger] = t('sessions.flashes.invalid_login')
      render 'new'
    end
  end

  def destroy
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    redirect_to login_path
  end

  private

  def create_params
    params.require(:session).permit(:username, :password)
  end
end