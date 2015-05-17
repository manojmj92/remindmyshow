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

ActiveRecord::Schema.define(version: 20141201170514) do

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["name"], name: "index_on_name", using: :btree

  create_table "movie_locations", force: true do |t|
    t.integer  "movie_id"
    t.integer  "location_id"
    t.boolean  "started",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_locations", ["started"], name: "index_on_started", using: :btree

  create_table "movies", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "link"
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movies", ["name"], name: "index_on_name", using: :btree
  add_index "movies", ["release_date"], name: "index_on_release_date", using: :btree

  create_table "user_movie_locations", force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_location_id"
    t.boolean  "email_sent",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_movie_locations", ["movie_location_id"], name: "index_on_movie_location_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_on_email", using: :btree

end
