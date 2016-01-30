# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160130033929) do

  create_table "accounts", primary_key: "userid", force: :cascade do |t|
    t.string   "username",             limit: 16,  default: "",               null: false
    t.datetime "created"
    t.string   "password",             limit: 34
    t.string   "email",                limit: 64
    t.string   "pseudo",               limit: 64
    t.datetime "login"
    t.datetime "changed"
    t.integer  "poll",                 limit: 1
    t.string   "group_bit",            limit: 1
    t.string   "spec_message"
    t.string   "grad_year",            limit: 4
    t.integer  "edit_cols",            limit: 1
    t.integer  "edit_rows",            limit: 1
    t.string   "webview",              limit: 1,   default: "0"
    t.string   "notes_asc",            limit: 1
    t.string   "user_type",            limit: 128
    t.boolean  "show_images",                      default: false,            null: false
    t.string   "guest_password",       limit: 30
    t.boolean  "is_admin",                         default: false
    t.string   "persistence_token"
    t.string   "password_salt"
    t.string   "perishable_token",                 default: "",               null: false
    t.string   "forem_state",                      default: "pending_review"
    t.boolean  "forem_auto_subscribe",             default: false
  end

  add_index "accounts", ["changed"], name: "changed"
  add_index "accounts", ["password"], name: "password"
  add_index "accounts", ["password"], name: "password_2"
  add_index "accounts", ["perishable_token"], name: "index_accounts_on_perishable_token"
  add_index "accounts", ["username"], name: "username", unique: true
  add_index "accounts", ["username"], name: "username_2"

  create_table "autofinger", id: false, force: :cascade do |t|
    t.integer  "owner",    limit: 2, default: 0, null: false
    t.integer  "interest", limit: 2, default: 0, null: false
    t.integer  "priority", limit: 1
    t.string   "updated",  limit: 1
    t.datetime "updtime"
    t.datetime "readtime"
  end

  add_index "autofinger", ["interest"], name: "interest"
  add_index "autofinger", ["owner"], name: "owner"

  create_table "avail_links", primary_key: "linknum", force: :cascade do |t|
    t.string "linkname",     limit: 128
    t.text   "descr"
    t.text   "html_code",    limit: 255
    t.text   "static",       limit: 255
    t.string "rails_helper"
  end

  create_table "boardvotes", primary_key: "voteid", force: :cascade do |t|
    t.integer  "userid",    limit: 2, default: 0, null: false
    t.integer  "threadid",  limit: 2, default: 0, null: false
    t.integer  "messageid", limit: 2, default: 0, null: false
    t.datetime "vote_date",                       null: false
    t.integer  "vote",      limit: 2
  end

  create_table "display", primary_key: "userid", force: :cascade do |t|
    t.integer "interface", limit: 1
    t.integer "style",     limit: 1
  end

  create_table "forem_categories", force: :cascade do |t|
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "position",   default: 0
  end

  add_index "forem_categories", ["slug"], name: "index_forem_categories_on_slug", unique: true

  create_table "forem_forums", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count", default: 0
    t.string  "slug"
    t.integer "position",    default: 0
  end

  add_index "forem_forums", ["slug"], name: "index_forem_forums_on_slug", unique: true

  create_table "forem_groups", force: :cascade do |t|
    t.string "name"
  end

  add_index "forem_groups", ["name"], name: "index_forem_groups_on_name"

  create_table "forem_memberships", force: :cascade do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], name: "index_forem_memberships_on_group_id"

  create_table "forem_moderator_groups", force: :cascade do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], name: "index_forem_moderator_groups_on_forum_id"

  create_table "forem_posts", force: :cascade do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_to_id"
    t.string   "state",       default: "pending_review"
    t.boolean  "notified",    default: false
  end

  add_index "forem_posts", ["reply_to_id"], name: "index_forem_posts_on_reply_to_id"
  add_index "forem_posts", ["state"], name: "index_forem_posts_on_state"
  add_index "forem_posts", ["topic_id"], name: "index_forem_posts_on_topic_id"
  add_index "forem_posts", ["user_id"], name: "index_forem_posts_on_user_id"

  create_table "forem_subscriptions", force: :cascade do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", force: :cascade do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",       default: false,            null: false
    t.boolean  "pinned",       default: false
    t.boolean  "hidden",       default: false
    t.datetime "last_post_at"
    t.string   "state",        default: "pending_review"
    t.integer  "views_count",  default: 0
    t.string   "slug"
  end

  add_index "forem_topics", ["forum_id"], name: "index_forem_topics_on_forum_id"
  add_index "forem_topics", ["slug"], name: "index_forem_topics_on_slug", unique: true
  add_index "forem_topics", ["state"], name: "index_forem_topics_on_state"
  add_index "forem_topics", ["user_id"], name: "index_forem_topics_on_user_id"

  create_table "forem_views", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             default: 0
    t.string   "viewable_type"
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], name: "index_forem_views_on_updated_at"
  add_index "forem_views", ["user_id"], name: "index_forem_views_on_user_id"
  add_index "forem_views", ["viewable_id"], name: "index_forem_views_on_viewable_id"

  create_table "interface", primary_key: "interface", force: :cascade do |t|
    t.string "path",  limit: 128
    t.string "descr"
  end

  create_table "js_status", id: false, force: :cascade do |t|
    t.integer "userid"
    t.string  "status", limit: 3
  end

  create_table "mainboard", primary_key: "threadid", force: :cascade do |t|
    t.string   "title",       limit: 128
    t.datetime "created"
    t.datetime "lastupdated"
    t.integer  "userid",      limit: 2,   default: 0, null: false
  end

  create_table "migration_test", id: false, force: :cascade do |t|
    t.text "field1"
  end

  create_table "migration_version", id: false, force: :cascade do |t|
    t.integer "version"
  end

  create_table "opt_links", force: :cascade do |t|
    t.integer "userid",  limit: 2, default: 0, null: false
    t.integer "linknum", limit: 1
  end

  add_index "opt_links", ["userid"], name: "userid"

  create_table "perms", primary_key: "userid", force: :cascade do |t|
    t.string "status", limit: 32
  end

  create_table "plans", force: :cascade do |t|
    t.integer "user_id",   limit: 2
    t.text    "plan",      limit: 16777215
    t.text    "edit_text"
  end

  add_index "plans", ["user_id"], name: "plans_user_id_idx", unique: true

  create_table "poll_choices", primary_key: "poll_choice_id", force: :cascade do |t|
    t.integer  "poll_question_id"
    t.text     "html"
    t.datetime "created"
  end

  create_table "poll_questions", primary_key: "poll_question_id", force: :cascade do |t|
    t.text     "html"
    t.string   "type",    limit: 20
    t.datetime "created"
  end

  create_table "poll_votes", primary_key: "poll_vote_id", force: :cascade do |t|
    t.integer  "poll_choice_id"
    t.integer  "userid"
    t.datetime "created"
  end

  create_table "secrets", primary_key: "secret_id", force: :cascade do |t|
    t.text     "secret_text"
    t.datetime "date"
    t.string   "display",       limit: 5
    t.datetime "date_approved"
  end

  create_table "style", primary_key: "style", force: :cascade do |t|
    t.string "path",  limit: 128
    t.string "descr"
  end

  create_table "stylesheet", primary_key: "userid", force: :cascade do |t|
    t.text "stylesheet", limit: 255
  end

  create_table "subboard", primary_key: "messageid", force: :cascade do |t|
    t.integer  "threadid", limit: 2,   default: 0, null: false
    t.datetime "created"
    t.integer  "userid",   limit: 2,   default: 0, null: false
    t.string   "title",    limit: 128
    t.text     "contents",                         null: false
  end

  add_index "subboard", ["threadid"], name: "threadid"

  create_table "system", id: false, force: :cascade do |t|
    t.text "motd"
    t.text "poll"
  end

  create_table "tentative_accounts", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "user_type"
    t.string   "confirmation_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tentative_accounts", ["confirmation_token"], name: "index_tentative_accounts_on_confirmation_token"
  add_index "tentative_accounts", ["email"], name: "index_tentative_accounts_on_email"
  add_index "tentative_accounts", ["username"], name: "index_tentative_accounts_on_username"

  create_table "test", id: false, force: :cascade do |t|
    t.text "name"
  end

  create_table "viewed_secrets", primary_key: "userid", force: :cascade do |t|
    t.datetime "date"
  end

end
