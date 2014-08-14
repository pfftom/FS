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

ActiveRecord::Schema.define(version: 20140814193308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leagues", force: true do |t|
    t.string   "name",                       null: false
    t.string   "sport",                      null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "drafted",    default: false
    t.integer  "admin_id"
  end

  add_index "leagues", ["admin_id"], name: "index_leagues_on_admin_id", using: :btree

  create_table "nfl_players", force: true do |t|
    t.string   "yahoo_key",     null: false
    t.string   "yahoo_id",      null: false
    t.string   "name",          null: false
    t.string   "team",          null: false
    t.string   "position",      null: false
    t.string   "position_type", null: false
    t.integer  "bye",           null: false
    t.string   "avatar_url",    null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "points", force: true do |t|
    t.integer  "nfl_player_id",             null: false
    t.float    "value",                     null: false
    t.integer  "week",          default: 1, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "points", ["nfl_player_id"], name: "index_points_on_nfl_player_id", using: :btree

  create_table "rosters", force: true do |t|
    t.integer "team_id",                   null: false
    t.integer "player_id",                 null: false
    t.boolean "active",    default: false, null: false
  end

  add_index "rosters", ["player_id"], name: "index_rosters_on_player_id", using: :btree
  add_index "rosters", ["team_id"], name: "index_rosters_on_team_id", using: :btree

  create_table "stat_categories", force: true do |t|
    t.integer  "stat_id",    null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stats", force: true do |t|
    t.integer "value",         null: false
    t.integer "stat_id",       null: false
    t.string  "name",          null: false
    t.integer "nfl_player_id", null: false
  end

  add_index "stats", ["nfl_player_id"], name: "index_stats_on_nfl_player_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name",       null: false
    t.integer  "user_id",    null: false
    t.integer  "league_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teams", ["league_id"], name: "index_teams_on_league_id", using: :btree
  add_index "teams", ["user_id"], name: "index_teams_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",               null: false
    t.string   "password_digest",     null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "name",                null: false
    t.string   "user_name",           null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
