class AddRawAuthToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :raw_auth, :text
  end

  def self.down
    remove_column :users, :raw_auth
  end
end
