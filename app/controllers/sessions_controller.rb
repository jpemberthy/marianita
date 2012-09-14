# Maybe Session isn't a clear name here :P.
class SessionsController < ApplicationController
  # For now only FB.
  def create
    user = if params[:provider] == "facebook"
      User.from_fb(env["omniauth.auth"])
    elsif params[:provider] == "twitter"
      User.from_twitter(env["omniauth.auth"])
    end

    render json: user
  end

end
