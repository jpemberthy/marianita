Instagram.configure do |config|
  config.client_id = Site.instagram_credentials["client_id"]
  config.client_secret = Site.instagram_credentials["client_secret"]
end
