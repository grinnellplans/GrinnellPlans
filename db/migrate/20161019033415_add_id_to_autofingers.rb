class AddIdToAutofingers < ActiveRecord::Migration
  def change
    change_table :autofinger do |t|
      t.column :id, :primary_key
    end
  end
end
