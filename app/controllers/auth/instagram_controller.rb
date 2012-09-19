class Auth::InstagramController < ApplicationController
  before_filter :require_user

  def new
    redirect_to Instagram.authorize_url(redirect_uri: callback_url)
  end

  def create
    instagram = Instagram.get_access_token(params[:code], redirect_uri: callback_url)
    current_user.link_instagram(instagram)
    render json: current_user
  end

  private

  def callback_url
    Site.instagram_credentials["callback_url"]
  end

end
