module User::Twitter
  module InstanceMethods
    def twitter
      @twitter ||= Twitter::Client.new(twitter_token)
    end

    def twitter_token
      t = tokens.twitter.last
      { oauth_token: t.token, oauth_token_secret: t.oauth_token_secret }
    end

    def update_twitter_token(credentials)
      conditions = { token: credentials.token, oauth_token_secret: credentials.secret }
      tokens.twitter.where(conditions).first_or_initialize.tap do |token|
        token.provider = 'twitter'
        token.token = credentials.token
        token.oauth_token_secret = credentials.secret
        token.save!
      end
    end

    def twitter_feeds
      TwitterFeed.where(user_id: self.id)
    end
  end

  module ClassMethods
    def from_twitter(twitter, user=nil)
      user ||= where(twitter_id: twitter.uid).first_or_initialize

      user.tap do |user|
        user.twitter_id = twitter.uid
        user.name = twitter.info.name
        user.save!
        user.update_twitter_token(twitter.credentials)
        user
      end
    end
  end
end
