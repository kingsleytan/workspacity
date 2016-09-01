class SessionsController < ApplicationController

  before_action :authenticate!, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: user_params[:username])
               &.authenticate(user_params[:password])

    if user
      session[:id] = user.id
      # session[:id] = user.slug
      flash[:success] = "Welcome back #{user.username}"
      redirect_to root_path
    else
      flash[:danger] = "Error logging in"
      redirect_to new_session_path
    end

  end

  def destroy
    session.delete(:id)
    flash[:success] = "You've been logged out"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
