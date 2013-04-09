class DropLegacySourceTables < ActiveRecord::Migration
  def up
    drop_table :justifications
    drop_table :existing_services
    drop_table :evidence_types
    drop_table :directgov_links
  end

  def down
    create_table "directgov_links" do |t|
      t.text     "title"
      t.string   "directgov_id", :null => false
      t.integer  "need_id"
      t.boolean  "found",        :default => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "evidence_types" do |t|
      t.string   "name"
      t.integer  "weight"
      t.string   "type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "existing_services" do |t|
      t.text     "description"
      t.text     "link"
      t.boolean  "government_run"
      t.string   "kind"
      t.integer  "need_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "justifications" do |t|
      t.text     "details"
      t.integer  "need_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "file"
      t.integer  "evidence_type_id"
    end

    add_index "justifications", ["need_id"], :name => "index_justifications_on_need_id"
  end
end
