# Maybe Session isn't a clear name here :P.
class SessionsController < ApplicationController
  # For now only FB.
  def create
    render json: User.from_fb(env["omniauth.auth"])
  end
end
