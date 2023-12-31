# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_30_064215) do

  create_table "budgets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "budget_name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.bigint "category_id", null: false
    t.bigint "user_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_budgets_on_category_id"
    t.index ["user_group_id"], name: "index_budgets_on_user_group_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_group_id"], name: "index_categories_on_user_group_id"
  end

  create_table "transaction_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.integer "multiplier", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "date", null: false
    t.bigint "user_group_id", null: false
    t.bigint "user_id", null: false
    t.bigint "category_id"
    t.bigint "transaction_type_id", null: false
    t.bigint "wallet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "amount", precision: 20, scale: 5, null: false
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
    t.index ["user_group_id"], name: "index_transactions_on_user_group_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id"
  end

  create_table "user_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "user_group_name", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "mobile_number"
    t.boolean "user_group_owner", default: false
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_group_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["user_group_id"], name: "index_users_on_user_group_id"
  end

  create_table "wallets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "opening_balance", precision: 20, scale: 5, default: "0.0"
    t.decimal "in_amount", precision: 20, scale: 5, default: "0.0"
    t.decimal "out_amount", precision: 20, scale: 5, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "user_group_id", null: false
    t.index ["user_group_id"], name: "index_wallets_on_user_group_id"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "budgets", "categories"
  add_foreign_key "budgets", "user_groups"
  add_foreign_key "categories", "user_groups"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "transaction_types"
  add_foreign_key "transactions", "user_groups"
  add_foreign_key "transactions", "users"
  add_foreign_key "transactions", "wallets"
  add_foreign_key "users", "user_groups"
  add_foreign_key "wallets", "user_groups"
  add_foreign_key "wallets", "users"
end
