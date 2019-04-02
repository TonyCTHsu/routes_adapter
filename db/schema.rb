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

ActiveRecord::Schema.define(version: 2019_04_02_024043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "loopholes_node_pairs", force: :cascade do |t|
    t.string "start_node"
    t.string "end_node"
  end

  create_table "loopholes_routes", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "loopholes_node_pair_id"
    t.index ["loopholes_node_pair_id"], name: "index_loopholes_routes_on_loopholes_node_pair_id"
  end

  create_table "sentinels_routes", force: :cascade do |t|
    t.integer "route_id"
    t.integer "node"
    t.integer "index"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sniffers_node_times", force: :cascade do |t|
    t.string "start_node"
    t.string "end_node"
    t.integer "duration"
  end

  create_table "sniffers_routes", force: :cascade do |t|
    t.datetime "time"
  end

  create_table "sniffers_sequences", id: false, force: :cascade do |t|
    t.bigint "sniffers_route_id", null: false
    t.bigint "sniffers_node_time_id", null: false
    t.index ["sniffers_node_time_id"], name: "index_sniffers_sequences_on_sniffers_node_time_id"
    t.index ["sniffers_route_id"], name: "index_sniffers_sequences_on_sniffers_route_id"
  end

end
