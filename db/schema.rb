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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110609110317) do

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments_needs", :force => true do |t|
    t.integer "department_id"
    t.integer "need_id"
  end

  create_table "justifications", :force => true do |t|
    t.string   "kind"
    t.text     "details"
    t.integer  "need_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "justifications", ["need_id"], :name => "index_justifications_on_need_id"

  create_table "kinds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "needs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "kind_id"
    t.string   "status"
    t.string   "url"
    t.integer  "priority"
    t.integer  "creator_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "needs", ["kind_id"], :name => "index_needs_on_kind_id"

end
