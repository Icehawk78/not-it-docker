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

ActiveRecord::Schema.define(version: 20150611134628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_groups", force: true do |t|
    t.integer  "group_id"
    t.integer  "player_id"
    t.integer  "bank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_groups", ["group_id"], name: "index_player_groups_on_group_id", using: :btree
  add_index "player_groups", ["player_id"], name: "index_player_groups_on_player_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rolls", force: true do |t|
    t.integer  "trip_id"
    t.integer  "player_group_id"
    t.integer  "modifier"
    t.integer  "raw_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rolls", ["player_group_id"], name: "index_rolls_on_player_group_id", using: :btree
  add_index "rolls", ["trip_id"], name: "index_rolls_on_trip_id", using: :btree

  create_table "trips", force: true do |t|
    t.integer  "group_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trips", ["group_id"], name: "index_trips_on_group_id", using: :btree

end
