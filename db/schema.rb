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

ActiveRecord::Schema[7.0].define(version: 2023_10_13_024920) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "column_types", force: :cascade do |t|
    t.string "name", null: false, comment: "カラム型名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "columns", force: :cascade do |t|
    t.bigint "table_id", null: false, comment: "テーブルID"
    t.bigint "column_type_id", null: false, comment: "カラム型ID"
    t.string "name", null: false, comment: "カラム名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_type_id"], name: "index_columns_on_column_type_id"
    t.index ["table_id", "name"], name: "index_columns_on_table_id_and_name", unique: true
    t.index ["table_id"], name: "index_columns_on_table_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tables", force: :cascade do |t|
    t.bigint "product_id", null: false, comment: "プロダクトID"
    t.string "name", null: false, comment: "テーブル名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "name"], name: "index_tables_on_product_id_and_name", unique: true
    t.index ["product_id"], name: "index_tables_on_product_id"
  end

  add_foreign_key "columns", "column_types"
  add_foreign_key "columns", "tables"
  add_foreign_key "tables", "products"
end
