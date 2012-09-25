class InstagramFeed
  include ServiceFeed
  acts_as_service_feed service_name: "instagram", delete_keys: [:id]
end
