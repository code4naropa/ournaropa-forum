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

ActiveRecord::Schema.define(version: 20160526125532) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "ournaropa_forum_conversations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",      null: false
    t.text     "body",       null: false
    t.uuid     "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "ournaropa_forum_conversations", ["author_id"], name: "index_ournaropa_forum_conversations_on_author_id", using: :btree
  add_index "ournaropa_forum_conversations", ["slug"], name: "index_ournaropa_forum_conversations_on_slug", unique: true, using: :btree

  create_table "ournaropa_forum_conversations_users", force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "conversation_id"
  end

  add_index "ournaropa_forum_conversations_users", ["conversation_id"], name: "index_ournaropa_forum_conversations_users_on_conversation_id", using: :btree
  add_index "ournaropa_forum_conversations_users", ["user_id"], name: "index_ournaropa_forum_conversations_users_on_user_id", using: :btree

  create_table "ournaropa_forum_permitted_users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email",                         null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.boolean  "is_superuser",  default: false, null: false
    t.boolean  "has_signed_up", default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ournaropa_forum_permitted_users", ["email"], name: "index_ournaropa_forum_permitted_users_on_email", unique: true, using: :btree

  create_table "ournaropa_forum_replies", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.uuid     "author_id"
    t.uuid     "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "ournaropa_forum_replies", ["author_id"], name: "index_ournaropa_forum_replies_on_author_id", using: :btree
  add_index "ournaropa_forum_replies", ["conversation_id"], name: "index_ournaropa_forum_replies_on_conversation_id", using: :btree

  create_table "ournaropa_forum_user_infos", force: :cascade do |t|
    t.string   "hometown"
    t.string   "major"
    t.string   "age"
    t.text     "description"
    t.boolean  "show_email",          default: false, null: false
    t.uuid     "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "share_email",         default: false, null: false
  end

  add_index "ournaropa_forum_user_infos", ["user_id"], name: "index_ournaropa_forum_user_infos_on_user_id", using: :btree

  create_table "ournaropa_forum_users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email",                                         null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.string   "password_hash",                                 null: false
    t.string   "reset_token"
    t.boolean  "is_superuser",                  default: false, null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "is_receiving_inactivity_email", default: true,  null: false
    t.datetime "inactivity_email_sent_at"
    t.datetime "seen_at"
  end

  add_index "ournaropa_forum_users", ["email"], name: "index_ournaropa_forum_users_on_email", unique: true, using: :btree

end
