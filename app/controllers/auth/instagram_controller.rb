class Auth::InstagramController < ApplicationController

  def new
    redirect_to Instagram.authorize_url(redirect_uri: callback_url)
  end

  def create
    # TODO: current_user.link_instagram.
    response = Instagram.get_access_token(params[:code], redirect_uri: callback_url)
    render json: response
  end

  private

  def callback_url
    Site.instagram_credentials["callback_url"]
  end

end
