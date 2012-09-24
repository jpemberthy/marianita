class User < ActiveRecord::Base
  has_many :tokens
  has_many :feeds

  validates_uniqueness_of :facebook_id, if: Proc.new { |u| u.facebook_id.present? }
  validates_uniqueness_of :twitter_id, if: Proc.new { |u| u.twitter_id.present? }
  validates_uniqueness_of :email, if: Proc.new { |u| u.email.present? }

  include User::Facebook::InstanceMethods
  extend User::Facebook::ClassMethods

  # TODO: Wrap in a Twitter module.
  def twitter
    @twitter ||= Twitter::Client.new(twitter_token)
  end

  def twitter_token
    t = tokens.twitter.last
    { oauth_token: t.token, oauth_token_secret: t.oauth_token_secret }
  end

  def self.from_twitter(twitter, user=nil)
    user ||= where(twitter_id: twitter.uid).first_or_initialize

    user.tap do |user|
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

  # Instagram
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
