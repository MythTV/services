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

ActiveRecord::Schema[8.0].define(version: 2025_02_04_184203) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "atsc_ids", id: false, force: :cascade do |t|
    t.integer "transportid"
    t.integer "major_chan"
    t.integer "minor_chan"
    t.integer "icon_id"
    t.index ["transportid", "major_chan", "minor_chan"], name: "atsc_idx", unique: true
  end

  create_table "blocked_atsc_ids", id: false, force: :cascade do |t|
    t.integer "transportid"
    t.integer "major_chan"
    t.integer "minor_chan"
    t.integer "icon_id"
    t.index ["transportid", "major_chan", "minor_chan", "icon_id"], name: "b_atsc_idx", unique: true
  end

  create_table "blocked_callsigns", id: false, force: :cascade do |t|
    t.text "callsign"
    t.integer "icon_id"
    t.index ["callsign", "icon_id"], name: "b_callsign_idx", unique: true
  end

  create_table "blocked_dvb_ids", id: false, force: :cascade do |t|
    t.integer "transportid"
    t.integer "networkid"
    t.integer "serviceid"
    t.integer "icon_id"
    t.index ["transportid", "networkid", "serviceid", "icon_id"], name: "b_dvb_idx", unique: true
  end

  create_table "blocked_ips", force: :cascade do |t|
    t.integer "ip", limit: 8
    t.integer "expire", limit: 8
    t.integer "user"
    t.integer "reason"
  end

  create_table "blocked_xmltvids", id: false, force: :cascade do |t|
    t.text "xmltvid"
    t.integer "icon_id"
    t.index ["xmltvid", "icon_id"], name: "b_xmltvid_idx", unique: true
  end

  create_table "callsigns", id: false, force: :cascade do |t|
    t.text "callsign"
    t.integer "icon_id"
    t.index ["callsign"], name: "callsigns_idx", unique: true
  end

  create_table "db_vers", id: false, force: :cascade do |t|
    t.integer "vers"
  end

  create_table "dvb_ids", id: false, force: :cascade do |t|
    t.integer "transportid"
    t.integer "networkid"
    t.integer "serviceid"
    t.integer "icon_id"
    t.index ["transportid", "networkid", "serviceid"], name: "dvb_idx", unique: true
  end

  create_table "icons", primary_key: "icon_id", force: :cascade do |t|
    t.integer "source_id"
    t.text "source_tag"
    t.text "name"
    t.text "icon"
    t.boolean "enabled"
    t.index ["source_id", "source_tag"], name: "index_icons_on_source_id_and_source_tag", unique: true
  end

  create_table "pending_atsc", force: :cascade do |t|
    t.integer "ip", limit: 8
    t.integer "transportid"
    t.integer "major_chan"
    t.integer "minor_chan"
    t.text "channame"
    t.integer "icon_id"
    t.index ["transportid", "major_chan", "minor_chan", "ip"], name: "pa_idx", unique: true
  end

  create_table "pending_callsign", force: :cascade do |t|
    t.integer "ip", limit: 8
    t.text "callsign"
    t.text "channame"
    t.integer "icon_id"
    t.index ["callsign", "ip"], name: "pc_idx", unique: true
  end

  create_table "pending_dvb", force: :cascade do |t|
    t.integer "ip", limit: 8
    t.integer "transportid"
    t.integer "networkid"
    t.integer "serviceid"
    t.text "channame"
    t.integer "icon_id"
    t.index ["transportid", "networkid", "serviceid", "ip"], name: "pd_idx", unique: true
  end

  create_table "pending_xmltvid", force: :cascade do |t|
    t.integer "ip", limit: 8
    t.text "xmltvid"
    t.text "channame"
    t.integer "icon_id"
    t.index ["xmltvid", "ip"], name: "px_idx", unique: true
  end

  create_table "sources", primary_key: "source_id", force: :cascade do |t|
    t.text "name"
    t.text "url"
  end

  create_table "xmltvids", id: false, force: :cascade do |t|
    t.text "xmltvid"
    t.integer "icon_id"
    t.index ["xmltvid"], name: "xmltvids_idx", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
