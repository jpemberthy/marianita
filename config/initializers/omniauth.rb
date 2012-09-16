OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Site.facebook_credentials["app_id"], Site.facebook_credentials["secret"],
           :scope => 'email,user_location,read_stream'

  provider :twitter,  Site.twitter_credentials["consumer_key"], Site.twitter_credentials["secret"]
end
