class Feed < ActiveRecord::Base
  belongs_to :user
  attr_accessible :score, :service, :story_id

  validates_presence_of :user, :service, :story_id
  validates_uniqueness_of :story_id, :scope => :service
  validates_numericality_of :score, :greater_than => 0
end
