class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweeted_at, null: false
      t.string :full_text, null: false
      t.string :url, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :tweets, :user_id
  end
end
