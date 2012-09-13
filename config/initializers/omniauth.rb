OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  credentials_path = File.join(Rails.root, %w[config facebook.yml])
  credentials = YAML.load_file(credentials_path)[Rails.env]

  provider :facebook, credentials["app_id"], credentials["secret"],
           :scope => 'email,user_location,read_stream'
end
