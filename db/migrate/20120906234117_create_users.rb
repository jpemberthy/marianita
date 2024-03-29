class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :facebook_id

      t.timestamps
    end

    add_index :users, :facebook_id
  end
end