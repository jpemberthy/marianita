class FacebookFeed
  include Mongoid::Document
  field :user_id, type: Integer

  # TODO: validations!

  # TODO: make it work with update. (find by facebook_id)
  def self.create_from_facebook(user_id, facebook_feed)
    facebook_feed.merge!(user_id: user_id, facebook_id: facebook_feed["id"])
    facebook_feed.delete("id")
    create(facebook_feed)
  end

end
