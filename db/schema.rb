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

ActiveRecord::Schema.define(version: 20161104135053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "node_relations", force: :cascade do |t|
    t.integer  "slave_node_id"
    t.integer  "master_node_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["master_node_id"], name: "index_node_relations_on_master_node_id", using: :btree
    t.index ["slave_node_id"], name: "index_node_relations_on_slave_node_id", using: :btree
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tree_nodes", force: :cascade do |t|
    t.integer  "tree_id"
    t.integer  "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_tree_nodes_on_node_id", using: :btree
    t.index ["tree_id"], name: "index_tree_nodes_on_tree_id", using: :btree
  end

  create_table "trees", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "tree_nodes", "nodes"
  add_foreign_key "tree_nodes", "trees"
end
