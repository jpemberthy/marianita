module Feeder

  # creates or updates existing feeds for all users.
  def self.create_facebook_feeds
    User.where("facebook_id IS NOT NULL").find_each do |user|
      feeds = user.facebook.get_connections("me", "feed")
      feeds.each { |feed| FacebookFeed.create_from_facebook(user.id, feed) }
    end
  end

end