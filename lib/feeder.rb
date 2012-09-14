module Feeder

  # creates or updates existing feeds for all users.
  def self.create_facebook_feeds
    User.where("facebook_id IS NOT NULL").find_each do |user|
      feeds = user.facebook.get_connections("me", "feed")
      feeds.each { |feed| FacebookFeed.create_from_facebook(user.id, feed) }
    end
  end

  def self.create_twitter_feeds
    User.where("twitter_id IS NOT NULL").find_each do |user|
      feeds = user.twitter.user_timeline(trim_user: true, include_entities: true)
      feeds.each { |feed| TwitterFeed.create_from_twitter(user.id, feed.attrs) }
    end
  end

end
