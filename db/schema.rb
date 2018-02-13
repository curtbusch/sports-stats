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

ActiveRecord::Schema.define(version: 20180213012411) do

  create_table "coaches", force: :cascade do |t|
    t.string "name"
    t.boolean "isHeadCoach"
    t.integer "teamId"
    t.string "college"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "teamId"
    t.integer "jersey_number"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name"
    t.string "city"
    t.string "conference"
    t.string "division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "league_id"
  end

end
