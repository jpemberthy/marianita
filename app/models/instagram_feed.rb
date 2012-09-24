class InstagramFeed
  include Mongoid::Document
  field :instagram_id, type: String
  field :user_id, type: Integer

  validates_presence_of :user_id, :instagram_id
  validates_uniqueness_of :instagram_id

  def self.create_from_instagram(user_id, instagram_feed)
    instagram_id = instagram_feed[:id]

    if feed = where(instagram_id: instagram_id).first
      feed.update_from_instagram(instagram_feed)
    else
      instagram_feed.merge!(user_id: user_id, instagram_id: instagram_id)
      instagram_feed.delete(:id)
      create(instagram_feed)
    end
  end

  def update_from_instagram(instagram_feed)
    instagram_feed.delete(:id)
    update_attributes(instagram_feed)
  end
end
