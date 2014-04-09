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

ActiveRecord::Schema.define(version: 20140409183620) do

  create_table "dive_fishes", force: true do |t|
    t.integer  "dive_id"
    t.integer  "fish_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diver_dives", force: true do |t|
    t.integer  "diver_id"
    t.integer  "dive_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "divers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.date     "birthday"
    t.string   "certification_level"
    t.string   "nationality"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "image"
  end

  create_table "dives", force: true do |t|
    t.date     "date"
    t.integer  "depth"
    t.integer  "temperature"
    t.time     "time_in"
    t.time     "time_out"
    t.string   "dive_site"
    t.integer  "visibility"
    t.integer  "start_air"
    t.integer  "end_air"
    t.string   "dive_type"
    t.string   "dive_activity"
    t.string   "wetsuit"
    t.string   "conditions"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fish", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "length"
    t.string   "wiki_link"
    t.string   "picture_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operators", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
