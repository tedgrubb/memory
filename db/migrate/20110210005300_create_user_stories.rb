class CreateUserStories < ActiveRecord::Migration
  def self.up
    create_table :user_stories do |t|
      t.integer :user_id
      t.integer :stroy_id
      t.boolean :owner

      t.timestamps
    end
  end

  def self.down
    drop_table :user_stories
  end
end
