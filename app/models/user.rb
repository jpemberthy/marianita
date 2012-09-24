class User < ActiveRecord::Base
  SERVICES = ['facebook', 'twitter', 'instagram']
  has_many :tokens
  has_many :feeds

  validates_uniqueness_of :facebook_id, if: Proc.new { |u| u.facebook_id.present? }
  validates_uniqueness_of :twitter_id, if: Proc.new { |u| u.twitter_id.present? }
  validates_uniqueness_of :email, if: Proc.new { |u| u.email.present? }

  SERVICES.each do |service|
    include "User::#{service.classify}::InstanceMethods".constantize
    extend "User::#{service.classify}::ClassMethods".constantize
  end
end
