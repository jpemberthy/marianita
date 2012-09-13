class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.string :service
      t.string :story_id
      t.integer :score

      t.timestamps
    end
  end
end
