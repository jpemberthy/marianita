class SessionsController < ApplicationController

  def create
    user = if params[:provider] == "facebook"
      User.from_fb(env["omniauth.auth"], current_user)
    elsif params[:provider] == "twitter"
      User.from_twitter(env["omniauth.auth"], current_user)
    end

    session[:user_id] = user.id
    render json: user
  end

end
