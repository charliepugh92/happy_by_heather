class SessionsController < ApplicationController
  skip_before_action :authenticate!
  before_action :create_params, only: [:create]

  def new
    redirect_to root_path if login_valid?
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      token = user.remember
      cookies.permanent.signed[:remember_token] = token.to_json
      cookies.permanent.signed[:user_id] = user.id

      redirect_to root_path
    else
      flash.now[:danger] = t('sessions.flashes.invalid_login')
      render 'new'
    end
  end

  def destroy
    RememberToken.find(JSON.parse(cookies.signed[:remember_token])['token_id']).destroy
    cookies.delete(:user_id)
    cookies.delete(:remember_token)

    redirect_to login_path
  end

  private

  def create_params
    params.require(:session).permit(:username, :password)
  end
end
