class TwitterFeed
  include ServiceFeed
  acts_as_service_feed service_name: "twitter", delete_keys: [:id, :id_str]
end
