# Think in a better name?
module Facebook

  # creates or updates existing feeds for all users.
  def self.create_feeds
    User.find_each do |user|
      feeds = user.facebook.get_connections("me", "feed")
      feeds.each { |feed| FacebookFeed.create_from_facebook(user.id, feed) }
    end
  end

end