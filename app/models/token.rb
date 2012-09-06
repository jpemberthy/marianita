class Token < ActiveRecord::Base
  attr_accessible :expires_at, :provider, :token, :user_id
end
