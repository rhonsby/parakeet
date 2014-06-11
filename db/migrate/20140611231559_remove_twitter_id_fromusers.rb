class RemoveTwitterIdFromusers < ActiveRecord::Migration
  def change
    remove_column :users, :twitter_id
  end
end
