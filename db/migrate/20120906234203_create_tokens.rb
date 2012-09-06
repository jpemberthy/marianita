class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :provider
      t.string :token
      t.datetime :expires_at
      t.integer :user_id

      t.timestamps
    end
    
    add_index :tokens, :user_id
  end
end