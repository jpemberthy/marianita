module User::Instagram
  module InstanceMethods
    def instagram
      @instagram ||= Instagram.client(access_token: tokens.instagram.last.token)
    end

    def link_instagram(instagram)
      client = Instagram.client(:access_token => instagram.access_token)

      self.tap do |user|
        user.instagram_id = client.user.id
        user.save!
        user.update_instagram_token(client.access_token)
        user
      end
    end

    def update_instagram_token(access_token)
      tokens.instagram.where(token: access_token).first_or_initialize.tap do |token|
        token.provider = 'instagram'
        token.token = access_token
        token.save!
      end
    end
  end

  module ClassMethods
  end
end
