source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'rails-api'

gem 'mongoid', '~> 3.0.2'

# Facebook
gem 'omniauth-facebook', '1.4.0'
gem 'koala'

group :production do
  gem 'pg'
end

group :development do
  gem 'heroku'  # TODO: created it from scratch. Production is using 1.9.2 - REPLACE!
end

group :development, :test do
  gem 'sqlite3'     # TODO: replace with PG once we start quering weird stuff.
  gem 'debugger'
  gem 'hirb'
  gem 'wirble'
end
