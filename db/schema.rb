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

ActiveRecord::Schema[7.0].define(version: 2023_05_26_190343) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "admins", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "request_logs", id: :serial, force: :cascade do |t|
    t.uuid "slider_id"
    t.uuid "user_id"
    t.text "referrer"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "sliders", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "title"
    t.string "short_code"
    t.jsonb "settings", default: {}
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "request_logs_count", default: 0
    t.string "width", default: "1600"
    t.string "height", default: "250"
    t.string "mode", default: "linear"
    t.string "speed", default: "500"
    t.boolean "auto_enabled", default: false
    t.string "auto_interval", default: "2000"
    t.boolean "controls_enabled", default: true
    t.boolean "pager_enabled", default: true
    t.integer "version"
    t.integer "track_logs_count", default: 0
    t.index ["short_code"], name: "index_sliders_on_short_code", unique: true
  end

  create_table "slides", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "slider_id", null: false
    t.text "content"
    t.integer "weight", default: 0, null: false
    t.string "image"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "track_logs", force: :cascade do |t|
    t.string "short_code"
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "slider_id"
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_hash"
    t.string "token"
    t.boolean "confirmed", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "subscription_type"
    t.string "stripe_customer_id"
    t.string "status"
    t.boolean "is_legacy", default: false
    t.string "stripe_subscription_id"
    t.datetime "trial_ends_at"
    t.datetime "stripe_purchased_at"
    t.datetime "trial_reminder_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
