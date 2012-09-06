OmniAuth.config.logger = Rails.logger

# TODO: make credentials work based on the environment with fb-credentials.yml
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '268529246596995', 'a8675694ee39e3fd6ba7285611725d69'
end
