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

ActiveRecord::Schema.define(version: 2018_12_05_100112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.bigint "business_asset_id"
    t.string "type"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_asset_id"], name: "index_attachments_on_business_asset_id"
  end

  create_table "business_assets", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "geographical_location_id"
    t.integer "business_asset_manager_id"
    t.integer "construction_year"
    t.boolean "has_icpe"
    t.text "asset_type"
    t.decimal "occupancy_rate"
    t.decimal "office_area_share"
    t.decimal "potential_annual_rent"
    t.decimal "potential_annual_rent_sqm"
    t.decimal "height"
    t.decimal "land_surface"
    t.decimal "surface"
    t.text "general_condition"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geographical_location_id"], name: "index_business_assets_on_geographical_location_id"
    t.index ["user_id"], name: "index_business_assets_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "credit_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "geographical_locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
  end

  create_table "interests", force: :cascade do |t|
    t.bigint "geographical_location_id"
    t.string "type"
    t.text "desctription"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geographical_location_id"], name: "index_interests_on_geographical_location_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.bigint "business_asset_id"
    t.integer "tenant_id"
    t.decimal "annual_rent"
    t.decimal "annual_rent_sqm"
    t.date "start_date"
    t.date "end_date"
    t.date "break_date_1"
    t.string "break_date_2"
    t.date "break_date_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_asset_id"], name: "index_rentals_on_business_asset_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "business_asset_id"
    t.integer "buyer_id"
    t.integer "seller_id"
    t.decimal "price"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_asset_id"], name: "index_transactions_on_business_asset_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "job_title"
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attachments", "business_assets"
  add_foreign_key "business_assets", "geographical_locations"
  add_foreign_key "business_assets", "users"
  add_foreign_key "interests", "geographical_locations"
  add_foreign_key "rentals", "business_assets"
  add_foreign_key "transactions", "business_assets"
end
