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

ActiveRecord::Schema.define(version: 20151028121220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "booking_requests", force: :cascade do |t|
    t.integer  "flat_id"
    t.integer  "requester_id"
    t.text     "description"
    t.string   "status",       default: "pending"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.date     "start_date"
    t.date     "end_date"
  end

  add_index "booking_requests", ["flat_id"], name: "index_booking_requests_on_flat_id", using: :btree
  add_index "booking_requests", ["requester_id"], name: "index_booking_requests_on_requester_id", using: :btree

  create_table "flat_pictures", force: :cascade do |t|
    t.integer  "flat_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "flat_pictures", ["flat_id"], name: "index_flat_pictures_on_flat_id", using: :btree

  create_table "flats", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "title"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "zip_code"
    t.string   "city"
    t.string   "country"
    t.integer  "rooms_number"
    t.integer  "bed_number"
    t.integer  "bathroom_number"
    t.integer  "people_number"
    t.boolean  "smoker"
    t.boolean  "television"
    t.boolean  "internet"
    t.string   "kind"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "price"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "flats", ["owner_id"], name: "index_flats_on_owner_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "profile_picture"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "flat_id"
    t.integer  "rating"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["flat_id"], name: "index_reviews_on_flat_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "admin",                  default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "booking_requests", "flats"
  add_foreign_key "booking_requests", "users", column: "requester_id"
  add_foreign_key "flat_pictures", "flats"
  add_foreign_key "flats", "users", column: "owner_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "reviews", "flats"
  add_foreign_key "reviews", "users"
end
