class FacebookFeed
  include Mongoid::Document
  field :user_id, type: Integer
  field :facebook_id, type: String

  validates_presence_of :user_id, :facebook_id
  validates_uniqueness_of :facebook_id

  def self.create_from_facebook(user_id, facebook_feed)
    facebook_id = facebook_feed["id"]

    if feed = where(facebook_id: facebook_id).first
      feed.update_from_facebook(facebook_feed)
    else
      facebook_feed.merge!(user_id: user_id, facebook_id: facebook_id)
      facebook_feed.delete("id")
      create(facebook_feed)
    end
  end

  def update_from_facebook(facebook_feed)
    facebook_feed.delete("id")
    update_attributes(facebook_feed)
  end

end
