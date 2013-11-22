class ModifyTentativeAccounts < ActiveRecord::Migration
  def self.up
    drop_table :tentative_accounts
    create_table :tentative_accounts do |t|
      t.string :username, :email, :user_type, :confirmation_token
      t.timestamps
    end
    add_index :tentative_accounts, :username
    add_index :tentative_accounts, :email
    add_index :tentative_accounts, :confirmation_token
  end

  def self.down
    drop_table :tentative_accounts
    create_table :tentative_accounts do |t|
      t.integer :tentative_accounts_id
      t.string :token, length: 16
      t.string session: 200
      t.timestamps
      t.primary_key :tentative_accounts_id
    end
  end
end
