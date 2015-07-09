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

ActiveRecord::Schema.define(version: 20150604145747) do

  create_table "actors", force: :cascade do |t|
    t.string  "name",          limit: 191
    t.string  "screen_name",   limit: 191
    t.integer "nature",        limit: 4,   default: 0
    t.integer "relevant_year", limit: 4
    t.string  "real_username", limit: 191
  end

  add_index "actors", ["screen_name"], name: "index_actors_on_screen_name", using: :btree

  create_table "mentions", force: :cascade do |t|
    t.string  "mention_date",             limit: 191
    t.boolean "favorited",                limit: 1
    t.string  "in_reply_to_screen_name",  limit: 191
    t.string  "permanent_link",           limit: 191
    t.string  "lang",                     limit: 191
    t.string  "source",                   limit: 191
    t.text    "text",                     limit: 65535
    t.text    "user_profile_description", limit: 65535
    t.string  "user_profile_location",    limit: 191
    t.string  "user_date",                limit: 191
    t.integer "user_followers_count",     limit: 4
    t.string  "user_name",                limit: 191
    t.string  "user_screen_name",         limit: 191
    t.string  "user_time_zone",           limit: 191
    t.integer "actor_id",                 limit: 4
  end

  add_index "mentions", ["actor_id"], name: "index_mentions_on_actor_id", using: :btree

  create_table "protests", force: :cascade do |t|
    t.string   "to",           limit: 191
    t.string   "from",         limit: 191
    t.datetime "created_date"
    t.date     "protest"
    t.integer  "actor_id",     limit: 4
  end

  add_index "protests", ["protest"], name: "index_protests_on_protest", using: :btree
  add_index "protests", ["to"], name: "index_protests_on_to", using: :btree

  create_table "ranking_tweets", force: :cascade do |t|
    t.string  "tweet_date",               limit: 191
    t.boolean "favorited",                limit: 1
    t.string  "in_reply_to_screen_name",  limit: 191
    t.string  "permanent_link",           limit: 191
    t.string  "lang",                     limit: 191
    t.string  "source",                   limit: 191
    t.text    "text",                     limit: 65535
    t.text    "user_profile_description", limit: 65535
    t.string  "user_profile_location",    limit: 191
    t.string  "user_date",                limit: 191
    t.integer "user_followers_count",     limit: 4
    t.string  "user_name",                limit: 191
    t.string  "user_screen_name",         limit: 191
    t.string  "user_time_zone",           limit: 191
    t.integer "retweets",                 limit: 4
    t.integer "actor_id",                 limit: 4
  end

  create_table "retweets", force: :cascade do |t|
    t.integer  "actor_id",         limit: 4
    t.integer  "mention_id",       limit: 4
    t.text     "text",             limit: 65535
    t.string   "user_screen_name", limit: 191
    t.datetime "rt_date"
    t.integer  "tweet_id",         limit: 4
  end

  add_index "retweets", ["actor_id"], name: "index_retweets_on_actor_id", using: :btree
  add_index "retweets", ["tweet_id"], name: "index_retweets_on_tweet_id", using: :btree
  add_index "retweets", ["user_screen_name"], name: "index_retweets_on_user_screen_name", using: :btree

  create_table "tweets", force: :cascade do |t|
    t.string  "tweet_date",               limit: 191
    t.boolean "favorited",                limit: 1
    t.string  "in_reply_to_screen_name",  limit: 191
    t.string  "permanent_link",           limit: 191
    t.string  "lang",                     limit: 191
    t.string  "source",                   limit: 191
    t.text    "text",                     limit: 65535
    t.text    "user_profile_description", limit: 65535
    t.string  "user_profile_location",    limit: 191
    t.string  "user_date",                limit: 191
    t.integer "user_followers_count",     limit: 4
    t.string  "user_name",                limit: 191
    t.string  "user_screen_name",         limit: 191
    t.string  "user_time_zone",           limit: 191
    t.integer "actor_id",                 limit: 4
  end

  add_index "tweets", ["actor_id"], name: "index_tweets_on_actor_id", using: :btree
  add_index "tweets", ["user_screen_name"], name: "index_tweets_on_user_screen_name", using: :btree

end
