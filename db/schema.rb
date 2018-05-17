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

ActiveRecord::Schema.define(version: 20180517215034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "max_spots"
    t.string "departure_location"
    t.date "start_date"
    t.integer "price"
    t.bigint "tour_store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "starts_at"
    t.date "end_date"
    t.time "ends_at"
    t.index ["tour_store_id"], name: "index_activities_on_tour_store_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "image"
    t.integer "activity_id"
    t.integer "tour_store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tour_stores", force: :cascade do |t|
    t.text "address"
    t.string "phone"
    t.string "website"
    t.string "name"
    t.text "description"
    t.string "business_tax_id"
    t.string "regulator_id"
    t.string "logo"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_banner"
    t.index ["user_id"], name: "index_tour_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_photo"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "activities", "tour_stores"
  add_foreign_key "tour_stores", "users"
end
