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

ActiveRecord::Schema[7.0].define(version: 2023_09_12_130304) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "garden_plants", force: :cascade do |t|
    t.string "nickname"
    t.string "pot_color"
    t.bigint "plant_id", null: false
    t.bigint "garden_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["garden_id"], name: "index_garden_plants_on_garden_id"
    t.index ["plant_id"], name: "index_garden_plants_on_plant_id"
  end

  create_table "gardens", force: :cascade do |t|
    t.string "name"
    t.integer "light"
    t.integer "size"
    t.integer "care_willing"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "climate"
    t.index ["user_id"], name: "index_gardens_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.string "caducity"
    t.integer "final_size"
    t.integer "light_need"
    t.integer "water_need"
    t.integer "growth_speed"
    t.integer "care_frequency"
    t.integer "cold_resistance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "climate", array: true
    t.text "content"
  end

  create_table "reviews", force: :cascade do |t|
    t.float "note"
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "plant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_reviews_on_plant_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "activity"
    t.string "criticity"
    t.datetime "due_date"
    t.datetime "done_time"
    t.bigint "garden_plant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.boolean "done", default: false
    t.index ["garden_plant_id"], name: "index_tasks_on_garden_plant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "garden_plants", "gardens"
  add_foreign_key "garden_plants", "plants"
  add_foreign_key "gardens", "users"
  add_foreign_key "reviews", "plants"
  add_foreign_key "reviews", "users"
  add_foreign_key "tasks", "garden_plants"
end
