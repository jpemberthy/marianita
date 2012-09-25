class FacebookFeed
  include ServiceFeed
  acts_as_service_feed service_name: "facebook", delete_keys: [:id]
end
