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

ActiveRecord::Schema[7.1].define(version: 2025_09_16_095844) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: :cascade do |t|
    t.bigint "attacker_id", null: false
    t.bigint "defender_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "winner_id", null: false
    t.text "battle_log"
    t.index ["attacker_id"], name: "index_battles_on_attacker_id"
    t.index ["defender_id"], name: "index_battles_on_defender_id"
    t.index ["winner_id"], name: "index_battles_on_winner_id"
  end

  create_table "buildings", force: :cascade do |t|
    t.string "building_type"
    t.integer "level"
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "plot_id", null: false
    t.index ["plot_id"], name: "index_buildings_on_plot_id"
    t.index ["profile_id"], name: "index_buildings_on_profile_id"
  end

  create_table "equipment", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "equipment_item_id", null: false
    t.index ["equipment_item_id"], name: "index_equipment_on_equipment_item_id"
    t.index ["profile_id"], name: "index_equipment_on_profile_id"
  end

  create_table "equipment_items", force: :cascade do |t|
    t.string "name"
    t.string "equipment_type"
    t.integer "attack"
    t.integer "defense"
    t.integer "speed_bonus"
    t.integer "price_in_steps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "global_messages", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_global_messages_on_profile_id"
  end

  create_table "guild_memberships", force: :cascade do |t|
    t.bigint "guild_id", null: false
    t.bigint "profile_id", null: false
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guild_id"], name: "index_guild_memberships_on_guild_id"
    t.index ["profile_id"], name: "index_guild_memberships_on_profile_id"
  end

  create_table "guild_messages", force: :cascade do |t|
    t.text "content"
    t.bigint "profile_id", null: false
    t.bigint "guild_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guild_id"], name: "index_guild_messages_on_guild_id"
    t.index ["profile_id"], name: "index_guild_messages_on_profile_id"
  end

  create_table "guilds", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "leader_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tag", null: false
    t.integer "max_members"
    t.index ["leader_id"], name: "index_guilds_on_leader_id"
    t.index ["tag"], name: "index_guilds_on_tag", unique: true
  end

  create_table "map_plots", force: :cascade do |t|
    t.integer "pos_x"
    t.integer "pos_y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plots", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pos_x"
    t.integer "pos_y"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "username", null: false
    t.integer "attack", default: 100
    t.integer "defense", default: 100
    t.integer "steps", default: 0
    t.integer "wood", default: 500
    t.integer "stone", default: 500
    t.integer "metal", default: 500
    t.integer "level", default: 1
    t.integer "experience", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "speed_bonus", default: 0, null: false
    t.bigint "map_plot_id", null: false
    t.index ["map_plot_id"], name: "index_profiles_on_map_plot_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.integer "kind", null: false
    t.bigint "building_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 0
    t.datetime "last_collected_at"
    t.index ["building_id", "kind"], name: "index_resources_on_building_id_and_kind", unique: true
    t.index ["building_id"], name: "index_resources_on_building_id"
  end

  create_table "troops", force: :cascade do |t|
    t.string "troop_type"
    t.integer "level"
    t.integer "attack"
    t.integer "defense"
    t.integer "speed"
    t.bigint "building_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_troops_on_building_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "world_monsters", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.integer "pos_x"
    t.integer "pos_y"
    t.integer "hp", default: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "world_resources", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "pos_x"
    t.integer "pos_y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "battles", "profiles", column: "attacker_id"
  add_foreign_key "battles", "profiles", column: "defender_id"
  add_foreign_key "battles", "profiles", column: "winner_id"
  add_foreign_key "buildings", "plots"
  add_foreign_key "buildings", "profiles"
  add_foreign_key "equipment", "equipment_items"
  add_foreign_key "equipment", "profiles"
  add_foreign_key "global_messages", "profiles"
  add_foreign_key "guild_memberships", "guilds"
  add_foreign_key "guild_memberships", "profiles"
  add_foreign_key "guild_messages", "guilds"
  add_foreign_key "guild_messages", "profiles"
  add_foreign_key "guilds", "profiles", column: "leader_id"
  add_foreign_key "profiles", "map_plots"
  add_foreign_key "profiles", "users"
  add_foreign_key "resources", "buildings"
  add_foreign_key "troops", "buildings"
end
