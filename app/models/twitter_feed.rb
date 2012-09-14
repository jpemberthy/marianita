# TODO: replace with a has_feed helper to reuse
# create_from_twitter
# update_from_twitter
class TwitterFeed
  include Mongoid::Document
  field :user_id, type: Integer
  field :twitter_id, type: String

  validates_presence_of :user_id, :twitter_id
  validates_uniqueness_of :twitter_id

  # Important: FB returns stringified keys. Twitter symbolized.
  def self.create_from_twitter(user_id, twitter_feed)
    twitter_id = twitter_feed[:id]

    if feed = where(twitter_id: twitter_id).first
      feed.update_from_twitter(twitter_feed)
    else
      twitter_feed.merge!(user_id: user_id, twitter_id: twitter_id)
      twitter_feed.delete(:id)
      twitter_feed.delete(:id_str)
      create(twitter_feed)
    end
  end

  def update_from_twitter(twitter_feed)
    twitter_feed.delete("id")
    update_attributes(twitter_feed)
  end
end
