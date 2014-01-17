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

ActiveRecord::Schema.define(version: 20140117155048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.string   "title"
    t.text     "body",       null: false
    t.integer  "recipe_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    null: false
  end

  add_index "comments", ["recipe_id"], name: "index_comments_on_recipe_id", using: :btree

  create_table "identities", force: true do |t|
    t.string   "uid",        null: false
    t.string   "provider",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "recipe_tags", force: true do |t|
    t.integer  "recipe_id",  null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipe_tags", ["recipe_id", "tag_id"], name: "index_recipe_tags_on_recipe_id_and_tag_id", unique: true, using: :btree

  create_table "recipes", force: true do |t|
    t.string   "name",                               null: false
    t.integer  "time_in_minutes"
    t.string   "servings"
    t.text     "ingredients",                        null: false
    t.text     "directions",                         null: false
    t.text     "notes"
    t.string   "visibility",      default: "Public", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_number"
    t.string   "time_unit"
    t.integer  "user_id",                            null: false
  end

  add_index "recipes", ["name", "user_id"], name: "index_recipes_on_name_and_user_id", unique: true, using: :btree
  add_index "recipes", ["user_id"], name: "index_recipes_on_user_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    null: false
  end

  add_index "tags", ["name", "user_id"], name: "index_tags_on_name_and_user_id", unique: true, using: :btree
  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name",     null: false
    t.string   "last_name",      null: false
    t.string   "username",       null: false
    t.string   "photo_path"
    t.text     "profile_notes"
    t.datetime "last_signed_in"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
