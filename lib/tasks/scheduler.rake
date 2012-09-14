namespace :facebook do
  desc "creates or updates users facebook feeds"
  task :create_feeds => [:environment] do
    Feeder.create_facebook_feeds
  end
end
