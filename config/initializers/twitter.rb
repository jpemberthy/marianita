Twitter.configure do |config|
  config.consumer_key       = Site.twitter_credentials["consumer_key"]
  config.consumer_secret    = Site.twitter_credentials["secret"]
end
