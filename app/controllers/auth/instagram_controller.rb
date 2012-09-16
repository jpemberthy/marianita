class Auth::InstagramController < ApplicationController

  def new
    # TODO: fix me. Suddendly started giving me an invalid request error.
    redirect_to Instagram.authorize_url(redirect_to: callback_url)
  end

  def create
    response = Instagram.get_access_token(params[:code], redirect_url: callback_url)
    render json: response
  end

  private

  def callback_url
    Site.instagram_credentials["callback_url"]
  end

end
