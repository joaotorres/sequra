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

ActiveRecord::Schema.define(version: 2019_05_20_104315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disbursements", force: :cascade do |t|
    t.bigint "merchant_id"
    t.integer "amount_cents", default: 0, null: false
    t.integer "week"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_disbursements_on_merchant_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "cif"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "merchant_id"
    t.bigint "shopper_id"
    t.integer "amount_cents", default: 0, null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_orders_on_merchant_id"
    t.index ["shopper_id"], name: "index_orders_on_shopper_id"
  end

  create_table "shoppers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "nif"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "disbursements", "merchants"
  add_foreign_key "orders", "merchants"
  add_foreign_key "orders", "shoppers"
end
