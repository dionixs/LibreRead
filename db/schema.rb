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

ActiveRecord::Schema[7.0].define(version: 2022_10_07_105212) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "imports", force: :cascade do |t|
    t.string "filename", null: false
    t.string "mime_type", null: false
    t.text "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_imports_on_user_id"
  end

  create_table "note_tags", force: :cascade do |t|
    t.bigint "note_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id", "tag_id"], name: "index_note_tags_on_note_id_and_tag_id", unique: true
    t.index ["note_id"], name: "index_note_tags_on_note_id"
    t.index ["tag_id"], name: "index_note_tags_on_tag_id"
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
    t.index ["import_id"], name: "index_notes_on_import_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "imports", "users"
  add_foreign_key "note_tags", "notes"
  add_foreign_key "note_tags", "tags"
  add_foreign_key "notes", "imports"
  add_foreign_key "notes", "users"
  add_foreign_key "tags", "users"
end
