class AddAuthlogicColumns < ActiveRecord::Migration
  def self.up
    add_column :accounts, :persistence_token, :string
    add_column :accounts, :password_salt, :string
  end

  def self.down
    remove_column :accounts, :persistence_token
    remove_column :accounts, :password_salt
  end
end
