source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.8'
gem 'rails-api'

gem 'mongoid', '~> 3.0.2'

# Facebook
gem 'omniauth-facebook', '1.4.0'
gem 'koala'

# Twitter
gem 'omniauth-twitter'
gem 'twitter'

# Instagram
gem 'instagram'

gem 'exception_notification'

group :production do
  gem 'pg'
  gem 'thin'
end

group :development do
  gem 'heroku'  # TODO: created it from scratch. Production is using 1.9.2 - REPLACE!
end

group :development, :test do
  gem 'sqlite3'
  gem 'debugger'
  gem 'hirb'
  gem 'wirble'
  gem 'rspec-rails'
end

group :test do
  gem 'factory_girl_rails'
end
