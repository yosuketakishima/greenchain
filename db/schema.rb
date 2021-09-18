# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_18_100623) do

  create_table "deviations", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.timestamp "time"
    t.float "temperature"
    t.decimal "latitude", precision: 10
    t.decimal "longitude", precision: 10
    t.string "situation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_deviations_on_unit_id"
  end

  create_table "temperatures", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.timestamp "time"
    t.float "temperature"
    t.decimal "latitude", precision: 9, scale: 6
    t.decimal "longitude", precision: 9, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_temperatures_on_unit_id"
  end

  create_table "units", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "unit"
    t.string "origin"
    t.string "destination"
    t.string "owner"
    t.time "departure_time"
    t.time "arrival_time"
    t.integer "monday"
    t.integer "tuesday"
    t.integer "wednesday"
    t.integer "thursday"
    t.integer "friday"
    t.integer "saturday"
    t.integer "sunday"
    t.integer "upper_temperature"
    t.integer "lower_temperature"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_units_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "deviations", "units"
  add_foreign_key "temperatures", "units"
  add_foreign_key "units", "users"
end
