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

ActiveRecord::Schema[7.0].define(version: 2022_10_30_114759) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "user_role", ["admin", "moderator", "basic"]
  create_enum "user_status", ["active", "banned"]

  create_table "imports", force: :cascade do |t|
    t.string "filename", null: false
    t.string "mime_type", null: false
    t.text "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["created_at"], name: "index_imports_on_created_at"
    t.index ["user_id"], name: "index_imports_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.integer "place", null: false
    t.datetime "created_kindle_at", null: false
    t.text "clipping", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "import_id", null: false
    t.bigint "user_id", null: false
    t.index ["created_kindle_at"], name: "index_notes_on_created_kindle_at"
    t.index ["import_id"], name: "index_notes_on_import_id"
    t.index ["updated_at"], name: "index_notes_on_updated_at"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "note_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id", "tag_id"], name: "index_taggings_on_note_id_and_tag_id", unique: true
    t.index ["note_id"], name: "index_taggings_on_note_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["title"], name: "index_tags_on_title"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_token_digest"
    t.boolean "password_must_be_changed", default: false
    t.string "gravatar_hash"
    t.enum "role", default: "basic", null: false, enum_type: "user_role"
    t.enum "status", default: "active", null: false, enum_type: "user_status"
    t.string "password_reset_token"
    t.datetime "password_reset_token_sent_at"
    t.index "lower((email)::text)", name: "user_lower_email_idx", unique: true
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["password_reset_token"], name: "index_users_on_password_reset_token"
    t.index ["role"], name: "index_users_on_role"
    t.index ["status"], name: "index_users_on_status"
  end

  add_foreign_key "imports", "users"
  add_foreign_key "notes", "imports"
  add_foreign_key "notes", "users"
  add_foreign_key "taggings", "notes"
  add_foreign_key "taggings", "tags"
  add_foreign_key "tags", "users"
end
