# TODO: refactor notifications with block and notification error.
module Feeder

  # creates or updates existing feeds for all users.
  def self.create_facebook_feeds
    User.where("facebook_id IS NOT NULL").find_each do |user|
      begin
        feeds = user.facebook.get_connections("me", "feed")
        feeds.each { |feed| FacebookFeed.create_from_service(user.id, feed) }
      rescue Exception => e
        # TODO: SEND NOTIFICATION ERROR.
      end
    end
  end

  def self.create_twitter_feeds
    User.where("twitter_id IS NOT NULL").find_each do |user|
      begin
        feeds = user.twitter.user_timeline(trim_user: true, include_entities: true)
        feeds.each { |feed| TwitterFeed.create_from_service(user.id, feed.attrs) }
      rescue Exception => e
        # TODO: SEND NOTIFICATION ERROR.
      end
    end
  end

  def self.create_instagram_feeds
    User.where("instagram_id IS NOT NULL").find_each do |user|
      begin
        feeds = user.instagram.user_recent_media
        feeds.each { |feed| InstagramFeed.create_from_service(user.id, feed) }
      rescue Exception => e
        # TODO: SEND NOTIFICATION ERROR.
      end
    end
  end

end
