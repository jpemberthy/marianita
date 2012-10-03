module User::Facebook

  module InstanceMethods
    def facebook
      @facebook ||= Koala::Facebook::API.new(self.facebook_token)
    end

    def facebook_token
      tokens.facebook.last.token
    end

    def update_fb_token(fb_credentials)
      tokens.facebook.where(token: fb_credentials.token).first_or_initialize.tap do |token|
        token.provider = 'facebook'
        token.token = fb_credentials.token
        token.expires_at = Time.at(fb_credentials.expires_at)
        token.save!
      end
    end

    def facebook_feeds
      FacebookFeed.where(user_id: self.id)
    end

  end

  module ClassMethods
    def from_fb(fb, user=nil)
      user ||= where(facebook_id: fb.uid).first_or_initialize

      user.tap do |user|
        user.email = fb.info.email
        user.name = fb.info.name
        user.facebook_id = fb.uid
        user.save!
        user.update_fb_token(fb.credentials)
        user
      end
    end
  end
end
