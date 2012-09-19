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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120919043256) do

  create_table "feeds", :force => true do |t|
    t.integer  "user_id"
    t.string   "service"
    t.string   "story_id"
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tokens", :force => true do |t|
    t.string   "provider"
    t.string   "token"
    t.datetime "expires_at"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "oauth_token_secret"
  end

  add_index "tokens", ["user_id"], :name => "index_tokens_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "facebook_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "twitter_id"
    t.string   "instagram_id"
  end

  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"
  add_index "users", ["twitter_id"], :name => "index_users_on_twitter_id"

end
