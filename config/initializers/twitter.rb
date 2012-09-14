Twitter.configure do |config|
  # same code in omniauth.rb
  # TODO: a Site class containing all the site credentials?
  twitter_credentials_path = File.join(Rails.root, %w[config twitter.yml])
  twitter_credentials = YAML.load_file(twitter_credentials_path)[Rails.env]

  config.consumer_key       = twitter_credentials["consumer_key"]
  config.consumer_secret    = twitter_credentials["secret"]
end
