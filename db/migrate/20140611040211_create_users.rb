class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :twitter_id, null: false
      t.string :username, null: false
      t.string :name, null: false
      t.string :profile_image_url, null: false

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
