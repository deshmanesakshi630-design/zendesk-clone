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

ActiveRecord::Schema[8.1].define(version: 2026_10_10_101500) do
  create_table "comments", force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.integer "author_id", null: false
    t.text "body", null: false
    t.boolean "internal", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["ticket_id"], name: "index_comments_on_ticket_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_memberships_on_team_id"
    t.index ["user_id", "team_id"], name: "index_memberships_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "ticket_transfers", force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.integer "from_team_id", null: false
    t.integer "to_team_id", null: false
    t.integer "moved_by_id", null: false
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_team_id"], name: "index_ticket_transfers_on_from_team_id"
    t.index ["moved_by_id"], name: "index_ticket_transfers_on_moved_by_id"
    t.index ["ticket_id"], name: "index_ticket_transfers_on_ticket_id"
    t.index ["to_team_id"], name: "index_ticket_transfers_on_to_team_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "subject", null: false
    t.text "description"
    t.integer "status", default: 0, null: false
    t.integer "priority", default: 0, null: false
    t.integer "requester_id", null: false
    t.integer "team_id", null: false
    t.integer "assignee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_tickets_on_assignee_id"
    t.index ["requester_id"], name: "index_tickets_on_requester_id"
    t.index ["team_id"], name: "index_tickets_on_team_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "ticket_transfers", "teams", column: "from_team_id"
  add_foreign_key "ticket_transfers", "teams", column: "to_team_id"
  add_foreign_key "ticket_transfers", "tickets"
  add_foreign_key "ticket_transfers", "users", column: "moved_by_id"
  add_foreign_key "tickets", "teams"
  add_foreign_key "tickets", "users", column: "assignee_id"
  add_foreign_key "tickets", "users", column: "requester_id"
end
