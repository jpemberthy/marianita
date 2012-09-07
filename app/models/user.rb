class User < ActiveRecord::Base
  has_many :tokens

  def self.from_fb(fb)
    user = where(facebook_id: fb.uid).first_or_initialize.tap do |user|
      user.email = fb.info.email
      user.name = fb.info.name
      user.facebook_id = fb.uid
      user.save!
      user.update_fb_token(fb.credentials)
      user
    end
  end

  def update_fb_token(fb_credentials)
    tokens.where(token: fb_credentials.token).first_or_initialize.tap do |token|
      token.provider = 'facebook'
      token.token = fb_credentials.token
      token.expires_at = Time.at(fb_credentials.expires_at)
      token.save!
    end
  end

end
