class CreateBlocks < ActiveRecord::Migration
  def change
    create_table "blocks", id: false, force: :cascade do |t|
      t.integer "blocked_user_id",  limit: 3, default: 0, null: false
      t.integer "blocking_user_id", limit: 3, default: 0, null: false
    end

    add_index "blocks", ["blocked_user_id", "blocking_user_id"], name: "unique_idx", unique: true
    add_index "blocks", ["blocked_user_id"], name: "lovee_idx"
    add_index "blocks", ["blocking_user_id"], name: "lover_idx"
  end
end
