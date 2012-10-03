require 'spec_helper'

describe FacebookFeed do
  let(:user) { create(:user) }

  # "likes" => { "count" }
  # "comments" => { "count" }
  describe "#calculate_karma" do
    it "calculates the karma based on the number of comments" do
      feed = FacebookFeed.create_from_service(user.id, "likes" => { "count" => 2 }, "comments" => { "count" => 3 })
      feed.karma.should == 5

      feed = FacebookFeed.create_from_service(user.id, "comments" => { "count" => 3 })
      feed.karma.should == 3

      feed = FacebookFeed.create_from_service(user.id, "likes" => { "count" => 1 })
      feed.karma.should == 1

      feed = FacebookFeed.create_from_service(user.id, {})
      feed.karma.should == 0
    end
  end
end
