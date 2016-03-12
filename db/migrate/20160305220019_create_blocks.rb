class CreateBlocks < ActiveRecord::Migration
  def change
    create_table "blocks", primary_key: "blockid", force: :cascade do |t|
      t.integer "blocked_userid",  limit: 2, default: 0, null: false
      t.integer "blocking_userid", limit: 2, default: 0, null: false
    end

    add_index "blocks", ["blocked_userid", "blocking_userid"], name: "pair", unique: true
    add_index "blocks", ["blocked_userid"], name: "blocked"
    add_index "blocks", ["blocking_userid"], name: "blocking"
  end
end
