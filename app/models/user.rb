class User < ActiveRecord::Base
  has_many :tokens
  has_many :feeds

  validates_uniqueness_of :facebook_id, if: Proc.new { |u| u.facebook_id.present? }
  validates_uniqueness_of :twitter_id, if: Proc.new { |u| u.twitter_id.present? }
  validates_uniqueness_of :email, if: Proc.new { |u| u.email.present? }

  # Wrap in a Facebook module?
  def facebook
    @facebook ||= Koala::Facebook::API.new(self.facebook_token)
  end

  def facebook_token
    tokens.facebook.last.token
  end

  def self.from_fb(fb)
    # TODO: replace to support link fb account if already logged in with Twitter.
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
    tokens.facebook.where(token: fb_credentials.token).first_or_initialize.tap do |token|
      token.provider = 'facebook'
      token.token = fb_credentials.token
      token.expires_at = Time.at(fb_credentials.expires_at)
      token.save!
    end
  end

  # Wrap in a twitter module?
  def twitter
    @twitter ||= Twitter::Client.new(twitter_token)
  end

  def twitter_token
    t = tokens.twitter.last
    { oauth_token: t.token, oauth_token_secret: t.oauth_token_secret }
  end

  def self.from_twitter(twitter)
    # TODO: replace to support link twitter account if already logged in with FB.
    user = where(twitter_id: twitter.uid).first_or_initialize.tap do |user|
      user.twitter_id = twitter.uid
      user.name = twitter.info.name
      user.save!
      user.update_twitter_token(twitter.credentials)
      user
    end
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
end
