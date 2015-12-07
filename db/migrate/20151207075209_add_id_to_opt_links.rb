class AddIdToOptLinks < ActiveRecord::Migration
  def change
    add_column :opt_links, :id, :primary_key
  end
end
