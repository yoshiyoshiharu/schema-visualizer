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

ActiveRecord::Schema[7.1].define(version: 2024_01_04_092410) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "column_memos", force: :cascade do |t|
    t.bigint "column_id", null: false, comment: "カラムID"
    t.string "content", default: "", null: false, comment: "内容"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_column_memos_on_column_id"
  end

  create_table "columns", comment: "カラム", force: :cascade do |t|
    t.bigint "table_id", null: false, comment: "テーブルID"
    t.string "name", null: false, comment: "カラム名"
    t.string "type", null: false, comment: "カラム型"
    t.string "comment", default: "", null: false, comment: "カラムコメント"
    t.boolean "nullable", default: false, null: false, comment: "NULL許容フラグ"
    t.boolean "primary_key", default: false, null: false, comment: "主キーフラグ"
    t.bigint "foreign_key_table_id", comment: "外部キー先テーブル"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["foreign_key_table_id"], name: "index_columns_on_foreign_key_table_id"
    t.index ["table_id", "name"], name: "index_columns_on_table_id_and_name", unique: true
    t.index ["table_id"], name: "index_columns_on_table_id"
  end

  create_table "products", comment: "プロダクト", force: :cascade do |t|
    t.string "name", null: false, comment: "プロダクト名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  create_table "tables", comment: "テーブル", force: :cascade do |t|
    t.bigint "product_id", null: false, comment: "プロダクトID"
    t.string "name", null: false, comment: "テーブル名"
    t.string "comment", default: "", null: false, comment: "テーブルコメント"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "name"], name: "index_tables_on_product_id_and_name", unique: true
    t.index ["product_id"], name: "index_tables_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "column_memos", "columns"
  add_foreign_key "columns", "tables"
  add_foreign_key "columns", "tables", column: "foreign_key_table_id"
  add_foreign_key "tables", "products"
end
