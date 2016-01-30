class DropForemAdminFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :forem_admin
  end
end
