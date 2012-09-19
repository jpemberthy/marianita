class Token < ActiveRecord::Base
  PROVIDERS = ['facebook', 'twitter', 'instagram']
  attr_accessible :expires_at, :provider, :token, :user_id

  PROVIDERS.each do |provider|
    scope provider, where(provider: provider)
  end
end
