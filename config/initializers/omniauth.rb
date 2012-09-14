OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  facebook_credentials_path = File.join(Rails.root, %w[config facebook.yml])
  facebook_credentials = YAML.load_file(facebook_credentials_path)[Rails.env]

  provider :facebook, facebook_credentials["app_id"], facebook_credentials["secret"],
           :scope => 'email,user_location,read_stream'

  provider :twitter,  'ePlCre6Ki1sIfbyDlkdQ', 'xSOHRLOOGzVHzcIRjt92vRqpchAoV8vOeiW1O0PAPa4'

end
