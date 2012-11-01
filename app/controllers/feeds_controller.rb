class FeedsController < ApplicationController
  before_filter :require_user

  def index
    render json: current_user.facebook_feeds.timeline
  end

end
