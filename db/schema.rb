# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "accounts", :primary_key => "userid", :force => true do |t|
    t.string   "username",       :limit => 16,  :default => "",    :null => false
    t.datetime "created"
    t.string   "password",       :limit => 34
    t.string   "email",          :limit => 64
    t.string   "pseudo",         :limit => 64
    t.datetime "login"
    t.datetime "changed"
    t.integer  "poll",           :limit => 1
    t.string   "group_bit",      :limit => 1
    t.string   "spec_message"
    t.string   "grad_year",      :limit => 4
    t.integer  "edit_cols",      :limit => 1
    t.integer  "edit_rows",      :limit => 1
    t.string   "webview",        :limit => 1,   :default => "0"
    t.string   "notes_asc",      :limit => 1
    t.string   "user_type",      :limit => 128
    t.boolean  "show_images",                   :default => false, :null => false
    t.string   "guest_password", :limit => 30
    t.boolean  "is_admin",                      :default => false
  end

  add_index "accounts", ["changed"], :name => "changed"
  add_index "accounts", ["password"], :name => "password"
  add_index "accounts", ["username", "changed"], :name => "username_changed"
  add_index "accounts", ["username", "userid"], :name => "usernameid_uniq", :unique => true
  add_index "accounts", ["username"], :name => "username", :unique => true

  create_table "autofinger", :id => false, :force => true do |t|
    t.integer  "owner",    :limit => 2, :default => 0, :null => false
    t.integer  "interest", :limit => 2, :default => 0, :null => false
    t.integer  "priority", :limit => 1
    t.string   "updated",  :limit => 1
    t.datetime "updtime"
    t.datetime "readtime"
  end

  add_index "autofinger", ["interest"], :name => "interest"
  add_index "autofinger", ["owner", "interest"], :name => "unique", :unique => true
  add_index "autofinger", ["owner"], :name => "owner"

  create_table "avail_links", :primary_key => "linknum", :force => true do |t|
    t.string "linkname",  :limit => 128
    t.text   "descr"
    t.text   "html_code", :limit => 255
    t.text   "static",    :limit => 255
  end

  create_table "boardvotes", :primary_key => "voteid", :force => true do |t|
    t.integer   "userid",    :limit => 2, :default => 0, :null => false
    t.integer   "threadid",  :limit => 2, :default => 0, :null => false
    t.integer   "messageid", :limit => 2, :default => 0, :null => false
    t.timestamp "vote_date",                             :null => false
    t.integer   "vote",      :limit => 2
  end

  create_table "display", :primary_key => "userid", :force => true do |t|
    t.integer "interface", :limit => 1
    t.integer "style",     :limit => 1
  end

  create_table "interface", :primary_key => "interface", :force => true do |t|
    t.string "path",  :limit => 128
    t.string "descr"
  end

  create_table "js_status", :id => false, :force => true do |t|
    t.integer "userid"
    t.string  "status", :limit => 3
  end

  add_index "js_status", ["userid"], :name => "userid_idx"

  create_table "mainboard", :primary_key => "threadid", :force => true do |t|
    t.string   "title",       :limit => 128
    t.datetime "created"
    t.datetime "lastupdated"
    t.integer  "userid",      :limit => 2,   :default => 0, :null => false
  end

  add_index "mainboard", ["lastupdated"], :name => "lastupdated"

  create_table "migration_test", :id => false, :force => true do |t|
    t.text "field1"
  end

  create_table "migration_version", :id => false, :force => true do |t|
    t.integer "version"
  end

  create_table "opt_links", :id => false, :force => true do |t|
    t.integer "userid",  :limit => 2, :default => 0, :null => false
    t.integer "linknum", :limit => 1
  end

  add_index "opt_links", ["userid"], :name => "userid"

  create_table "perms", :primary_key => "userid", :force => true do |t|
    t.string "status", :limit => 32
  end

  create_table "plans", :force => true do |t|
    t.integer "user_id",   :limit => 2
    t.text    "plan",      :limit => 16777215
    t.text    "edit_text"
  end

  add_index "plans", ["user_id"], :name => "plans_user_id_idx", :unique => true

  create_table "poll_choices", :primary_key => "poll_choice_id", :force => true do |t|
    t.integer  "poll_question_id"
    t.text     "html"
    t.datetime "created"
  end

  create_table "poll_questions", :primary_key => "poll_question_id", :force => true do |t|
    t.text     "html"
    t.string   "type",    :limit => 20
    t.datetime "created"
  end

  create_table "poll_votes", :primary_key => "poll_vote_id", :force => true do |t|
    t.integer  "poll_choice_id"
    t.integer  "userid"
    t.datetime "created"
  end

  create_table "secrets", :primary_key => "secret_id", :force => true do |t|
    t.text     "secret_text"
    t.datetime "date"
    t.string   "display",       :limit => 5
    t.datetime "date_approved"
  end

  add_index "secrets", ["display", "date_approved"], :name => "display_date"

  create_table "style", :primary_key => "style", :force => true do |t|
    t.string "path",  :limit => 128
    t.string "descr"
  end

  create_table "stylesheet", :primary_key => "userid", :force => true do |t|
    t.text "stylesheet", :limit => 255
  end

  create_table "subboard", :primary_key => "messageid", :force => true do |t|
    t.integer  "threadid", :limit => 2,   :default => 0, :null => false
    t.datetime "created"
    t.integer  "userid",   :limit => 2,   :default => 0, :null => false
    t.string   "title",    :limit => 128
    t.text     "contents",                               :null => false
  end

  add_index "subboard", ["threadid"], :name => "threadid"
  add_index "subboard", ["userid"], :name => "userid"

  create_table "system", :id => false, :force => true do |t|
    t.text "motd"
    t.text "poll"
  end

  create_table "tentative_accounts", :primary_key => "tentative_accounts_id", :force => true do |t|
    t.datetime "created"
    t.string   "token",   :limit => 16
    t.string   "session", :limit => 200
  end

  create_table "test", :id => false, :force => true do |t|
    t.text "name"
  end

  create_table "viewed_secrets", :primary_key => "userid", :force => true do |t|
    t.datetime "date"
  end

end
