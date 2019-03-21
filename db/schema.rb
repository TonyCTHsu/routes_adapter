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

ActiveRecord::Schema.define(version: 2019_03_21_173214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "loopholes_node_pairs", force: :cascade do |t|
    t.integer "start_node"
    t.integer "end_node"
  end

  create_table "loopholes_routes", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "loopholes_node_pairs_id"
    t.index ["loopholes_node_pairs_id"], name: "index_loopholes_routes_on_loopholes_node_pairs_id"
  end

  create_table "sentinels_routes", force: :cascade do |t|
    t.integer "route_id"
    t.integer "node"
    t.integer "index"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
