class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.bigint :friend_id

      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
