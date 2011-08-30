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

ActiveRecord::Schema.define(:version => 20110830120000) do

  create_table "audiences", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audiences_needs", :id => false, :force => true do |t|
    t.integer "audience_id"
    t.integer "need_id"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments_needs", :id => false, :force => true do |t|
    t.integer "department_id"
    t.integer "need_id"
  end

  create_table "directgov_links", :force => true do |t|
    t.text     "title"
    t.string   "directgov_id",                    :null => false
    t.integer  "need_id"
    t.boolean  "found",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evidence_types", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "existing_services", :force => true do |t|
    t.text     "description"
    t.text     "link"
    t.boolean  "government_run"
    t.string   "kind"
    t.integer  "need_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "justifications", :force => true do |t|
    t.text     "details"
    t.integer  "need_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.integer  "evidence_type_id"
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
    t.string   "status",              :default => "new"
    t.string   "url"
    t.integer  "priority"
    t.integer  "creator_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "decision_maker_id"
    t.datetime "decision_made_at"
    t.text     "reason_for_decision"
    t.text     "tag_list"
    t.integer  "search_rank"
    t.integer  "pairwise_rank"
    t.integer  "traffic"
    t.integer  "usage_volume"
    t.integer  "interaction"
    t.string   "related_needs"
    t.boolean  "statutory"
  end

  add_index "needs", ["kind_id"], :name => "index_needs_on_kind_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string  "name",    :null => false
    t.string  "uid",     :null => false
    t.integer "version", :null => false
    t.string  "email",   :null => false
  end

end
