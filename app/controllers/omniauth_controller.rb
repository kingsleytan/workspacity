class OmniauthController < ApplicationController
  layout false
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def failure
    render :create
  end
end
