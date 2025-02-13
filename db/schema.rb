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

ActiveRecord::Schema[7.0].define(version: 2025_01_16_180628) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.uuid "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "cart_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "cart_id", null: false
    t.uuid "variant_id", null: false
    t.integer "quantity"
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_cart_items_on_account_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["company_id"], name: "index_cart_items_on_company_id"
    t.index ["variant_id"], name: "index_cart_items_on_variant_id"
  end

  create_table "carts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "virtual_carts_id", null: false
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_carts_on_account_id"
    t.index ["company_id"], name: "index_carts_on_company_id"
    t.index ["virtual_carts_id"], name: "index_carts_on_virtual_carts_id"
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_categories_on_account_id"
    t.index ["company_id"], name: "index_categories_on_company_id"
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "account_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_companies_on_account_id"
  end

  create_table "customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "company_id", null: false
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_memberships_on_company_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "order_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "order_id", null: false
    t.uuid "variant_id", null: false
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "total_price"
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_order_items_on_account_id"
    t.index ["company_id"], name: "index_order_items_on_company_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["variant_id"], name: "index_order_items_on_variant_id"
  end

  create_table "orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "customer_name"
    t.integer "kind"
    t.integer "status"
    t.decimal "total_price"
    t.uuid "user_id"
    t.uuid "customer_id"
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_orders_on_account_id"
    t.index ["company_id"], name: "index_orders_on_company_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "order_id", null: false
    t.decimal "amount"
    t.string "payment_method"
    t.integer "status"
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_payments_on_account_id"
    t.index ["company_id"], name: "index_payments_on_company_id"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "kind"
    t.integer "status"
    t.boolean "multiple", default: false
    t.boolean "virtual", default: false
    t.uuid "category_id", null: false
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_products_on_account_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "stock_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "min_quantity", default: 0
    t.integer "quantity", default: 0
    t.decimal "price", default: "0.0"
    t.uuid "variant_id", null: false
    t.uuid "stock_id", null: false
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_stock_items_on_account_id"
    t.index ["company_id"], name: "index_stock_items_on_company_id"
    t.index ["stock_id"], name: "index_stock_items_on_stock_id"
    t.index ["variant_id"], name: "index_stock_items_on_variant_id"
  end

  create_table "stocks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "status", default: 0
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_stocks_on_account_id"
    t.index ["company_id"], name: "index_stocks_on_company_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name", null: false
    t.integer "role", default: 0
    t.integer "document_type", default: 0
    t.string "document_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "current_company_id"
    t.index ["current_company_id"], name: "index_users_on_current_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.string "sku"
    t.string "barcode"
    t.string "ean"
    t.jsonb "properties"
    t.integer "status"
    t.float "height"
    t.float "width"
    t.float "weight"
    t.float "length"
    t.string "gtin"
    t.string "mpn"
    t.string "ncm"
    t.string "code"
    t.string "slug"
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_variants_on_account_id"
    t.index ["company_id"], name: "index_variants_on_company_id"
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  create_table "virtual_carts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "account_id", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_virtual_carts_on_account_id"
    t.index ["company_id"], name: "index_virtual_carts_on_company_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_items", "accounts"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "companies"
  add_foreign_key "cart_items", "variants"
  add_foreign_key "carts", "accounts"
  add_foreign_key "carts", "companies"
  add_foreign_key "carts", "virtual_carts", column: "virtual_carts_id"
  add_foreign_key "categories", "accounts"
  add_foreign_key "categories", "companies"
  add_foreign_key "companies", "accounts"
  add_foreign_key "memberships", "companies"
  add_foreign_key "memberships", "users"
  add_foreign_key "order_items", "accounts"
  add_foreign_key "order_items", "companies"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "variants"
  add_foreign_key "orders", "accounts"
  add_foreign_key "orders", "companies"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "accounts"
  add_foreign_key "payments", "companies"
  add_foreign_key "payments", "orders"
  add_foreign_key "products", "accounts"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
  add_foreign_key "stock_items", "accounts"
  add_foreign_key "stock_items", "companies"
  add_foreign_key "stock_items", "stocks"
  add_foreign_key "stock_items", "variants"
  add_foreign_key "stocks", "accounts"
  add_foreign_key "stocks", "companies"
  add_foreign_key "users", "companies", column: "current_company_id"
  add_foreign_key "variants", "accounts"
  add_foreign_key "variants", "companies"
  add_foreign_key "variants", "products"
  add_foreign_key "virtual_carts", "accounts"
  add_foreign_key "virtual_carts", "companies"
end
