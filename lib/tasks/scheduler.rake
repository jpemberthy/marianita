namespace :facebook do
  desc "creates or updates users facebook feeds"
  task :create_feeds => [:environment] do
    Facebook.create_feeds
  end
end
