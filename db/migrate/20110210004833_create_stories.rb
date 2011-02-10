class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :location
      t.string :when
      t.text :what
      t.datetime :parsed_when
      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
