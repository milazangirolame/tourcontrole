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

ActiveRecord::Schema.define(version: 20180613175000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "max_spots"
    t.string "departure_location"
    t.bigint "tour_store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "recurring"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean "enabled", default: true
    t.date "start_day"
    t.string "slug"
    t.float "latitude"
    t.float "longitude"
    t.integer "price_cents", default: 0, null: false
    t.index ["tour_store_id"], name: "index_activities_on_tour_store_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "guest_id"
    t.bigint "event_id"
    t.bigint "order_id"
    t.index ["event_id"], name: "index_bookings_on_event_id"
    t.index ["guest_id"], name: "index_bookings_on_guest_id"
    t.index ["order_id"], name: "index_bookings_on_order_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_day"
    t.index ["activity_id"], name: "index_events_on_activity_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "buyer", default: false, null: false
  end

  create_table "iugu_apis", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "order_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "image"
    t.integer "activity_id"
    t.integer "tour_store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tour_store_admins", force: :cascade do |t|
    t.integer "tour_store_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "store_creator", default: false, null: false
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
    t.boolean "dummy", default: false, null: false
    t.string "slug"
    t.float "latitude"
    t.float "longitude"
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
  add_foreign_key "bookings", "events"
  add_foreign_key "bookings", "guests"
  add_foreign_key "bookings", "orders"
  add_foreign_key "events", "activities"
  add_foreign_key "tour_stores", "users"
end
