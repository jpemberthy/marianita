OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  facebook_credentials_path = File.join(Rails.root, %w[config facebook.yml])
  facebook_credentials = YAML.load_file(facebook_credentials_path)[Rails.env]

  provider :facebook, facebook_credentials["app_id"], facebook_credentials["secret"],
           :scope => 'email,user_location,read_stream'

  twitter_credentials_path = File.join(Rails.root, %w[config twitter.yml])
  twitter_credentials = YAML.load_file(twitter_credentials_path)[Rails.env]

  provider :twitter,  twitter_credentials["consumer_key"], twitter_credentials["secret"]
end
