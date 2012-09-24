class User < ActiveRecord::Base
  has_many :tokens
  has_many :feeds

  validates_uniqueness_of :facebook_id, if: Proc.new { |u| u.facebook_id.present? }
  validates_uniqueness_of :twitter_id, if: Proc.new { |u| u.twitter_id.present? }
  validates_uniqueness_of :email, if: Proc.new { |u| u.email.present? }

  ['facebook', 'twitter'].each do |service|
    include "User::#{service.classify}::InstanceMethods".constantize
    extend "User::#{service.classify}::ClassMethods".constantize
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
