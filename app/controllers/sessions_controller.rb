class SessionsController < ApplicationController
  skip_before_action :authenticate!
  before_action :authenticate!, only: [:destroy]
  before_action :create_params, only: [:create]

  def new; end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = 'Invalid username or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def create_params
    params.require(:session).require(:username)
    params.require(:session).require(:password)
    params.permit(:session)
    params.require(:session).permit(:username, :password)
  end
end