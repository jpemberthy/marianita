namespace :facebook do
  desc "creates or updates users facebook feeds"
  task :create_feeds => [:environment] do
    Feeder.create_facebook_feeds
  end
end

namespace :twitter do
  desc "creates or updates users twitter feeds"
  task :create_feeds => [:environment] do
    Feeder.create_twitter_feeds
  end
end
