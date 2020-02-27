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

ActiveRecord::Schema.define(version: 2020_02_27_223124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_log_items", force: :cascade do |t|
    t.string "event_type"
    t.bigint "trip_item_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_item_id"], name: "index_action_log_items_on_trip_item_id"
    t.index ["user_id"], name: "index_action_log_items_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "user_id"
    t.bigint "trip_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_item_id"], name: "index_comments_on_trip_item_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string "email"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_invites_on_trip_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "trip_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_item_id"], name: "index_likes_on_trip_item_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "trip_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_participants_on_trip_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "trip_items", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.date "start_date"
    t.date "end_date"
    t.text "description"
    t.integer "price"
    t.string "photo"
    t.string "link"
    t.boolean "confirmed"
    t.bigint "user_id"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_trip_items_on_category_id"
    t.index ["trip_id"], name: "index_trip_items_on_trip_id"
    t.index ["user_id"], name: "index_trip_items_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.string "name"
    t.float "longitude"
    t.float "latitude"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "photo"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "action_log_items", "trip_items"
  add_foreign_key "action_log_items", "users"
  add_foreign_key "comments", "trip_items"
  add_foreign_key "comments", "users"
  add_foreign_key "invites", "trips"
  add_foreign_key "likes", "trip_items"
  add_foreign_key "likes", "users"
  add_foreign_key "participants", "trips"
  add_foreign_key "participants", "users"
  add_foreign_key "trip_items", "categories"
  add_foreign_key "trip_items", "trips"
  add_foreign_key "trip_items", "users"
  add_foreign_key "trips", "users"
end
