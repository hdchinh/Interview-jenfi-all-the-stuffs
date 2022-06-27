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

ActiveRecord::Schema.define(version: 2022_06_27_084347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "api_key"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lines", force: :cascade do |t|
    t.string "name"
    t.boolean "blocked", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
  end

  create_table "packages", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "weight"
    t.float "volume"
    t.bigint "line_id", null: false
    t.index ["customer_id"], name: "index_packages_on_customer_id"
    t.index ["line_id"], name: "index_packages_on_line_id"
  end

  create_table "train_operators", force: :cascade do |t|
    t.string "name"
    t.integer "total_trains", default: 0
    t.string "api_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trains", force: :cascade do |t|
    t.float "max_weight"
    t.float "max_volume"
    t.float "cost"
    t.bigint "train_operator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: true
    t.jsonb "lines", default: []
    t.integer "status", default: 0
    t.index ["train_operator_id"], name: "index_trains_on_train_operator_id"
  end

  add_foreign_key "packages", "customers"
  add_foreign_key "packages", "lines"
  add_foreign_key "trains", "train_operators"
end
