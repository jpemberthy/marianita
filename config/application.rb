require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Marianita
  class Application < Rails::Application
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true
    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true
    # Enable the asset pipeline
    config.assets.enabled = true
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    # TODO: replace with AR store?
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    # AR should take precedence over mongoid.
    config.generators do |g|
      g.orm             :active_record
    end

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
