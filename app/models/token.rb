class Token < ActiveRecord::Base
  attr_accessible :expires_at, :provider, :token, :user_id
  scope :facebook, where('provider = ?', 'facebook')
  scope :twitter, where('provider = ?', 'twitter')
end
