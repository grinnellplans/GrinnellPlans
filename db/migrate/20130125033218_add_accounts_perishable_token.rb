class AddAccountsPerishableToken < ActiveRecord::Migration
  def up
    add_column :accounts, :perishable_token, :string, :default => "", :null => false
    add_index :accounts, :perishable_token
  end

  def down
    remove_column :accounts, :perishable_token
  end
end
