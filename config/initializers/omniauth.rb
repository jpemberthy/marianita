OmniAuth.config.logger = Rails.logger

# TODO: make credentials work based on the environment with fb-credentials.yml
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '280550815379979', '615f73b629c5241d5708439b198bc5a7'
end
