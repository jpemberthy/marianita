class InstagramFeed
  include ServiceFeed
  acts_as_service_feed service_name: "instagram", delete_keys: [:id]

  before_validation :calculate_karma

  def likes_count
    self["likes"]["count"] rescue 0
  end

  def comments_count
    self["comments"]["count"] rescue 0
  end

  private

  def calculate_karma
    self.karma = likes_count + comments_count
  end


end
