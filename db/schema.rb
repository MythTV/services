# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160119223446) do

  create_table "atsc_ids", force: :cascade do |t|
    t.integer "transportid"
    t.integer "major_chan"
    t.integer "minor_chan"
    t.integer "icon_id"
  end

  add_index "atsc_ids", ["transportid", "major_chan", "minor_chan"], name: "index_atsc_ids_on_transportid_and_major_chan_and_minor_chan", unique: true

  create_table "blocked_atsc_ids", force: :cascade do |t|
    t.integer "transportid"
    t.integer "major_chan"
    t.integer "minor_chan"
    t.integer "icon_id"
  end

  add_index "blocked_atsc_ids", ["transportid", "major_chan", "minor_chan", "icon_id"], name: "b_atsc_index", unique: true

  create_table "blocked_callsigns", force: :cascade do |t|
    t.text    "callsign"
    t.integer "icon_id"
  end

  add_index "blocked_callsigns", ["callsign", "icon_id"], name: "index_blocked_callsigns_on_callsign_and_icon_id", unique: true

  create_table "blocked_dvb_ids", force: :cascade do |t|
    t.integer "transportid"
    t.integer "networkid"
    t.integer "serviceid"
    t.integer "icon_id"
  end

  add_index "blocked_dvb_ids", ["transportid", "networkid", "serviceid", "icon_id"], name: "b_dvb_index", unique: true

  create_table "blocked_ips", force: :cascade do |t|
    t.integer "ip"
    t.integer "expire"
    t.integer "user"
    t.integer "reason"
  end

  create_table "blocked_xmltvids", force: :cascade do |t|
    t.text    "xmltvid"
    t.integer "icon_id"
  end

  create_table "callsigns", force: :cascade do |t|
    t.text    "callsign"
    t.text    "primary_key"
    t.integer "icon_id"
  end

  create_table "dvb_ids", force: :cascade do |t|
    t.integer "transportid"
    t.integer "networkid"
    t.integer "serviceid"
    t.integer "icon_id"
  end

  add_index "dvb_ids", ["transportid", "networkid", "serviceid"], name: "index_dvb_ids_on_transportid_and_networkid_and_serviceid", unique: true

  create_table "icons", force: :cascade do |t|
    t.integer "source_id"
    t.text    "source_tag"
    t.text    "name"
    t.text    "icon"
    t.boolean "enabled"
  end

  add_index "icons", ["source_id", "source_tag"], name: "index_icons_on_source_id_and_source_tag", unique: true

  create_table "pending_atsc", force: :cascade do |t|
    t.integer "ip"
    t.integer "transportid"
    t.integer "major_chan"
    t.integer "minor_chan"
    t.text    "channame"
    t.integer "icon_id"
  end

  add_index "pending_atsc", ["transportid", "major_chan", "minor_chan", "ip"], name: "pa_index", unique: true

  create_table "pending_callsign", force: :cascade do |t|
    t.integer "ip"
    t.text    "callsign"
    t.text    "channame"
    t.integer "icon_id"
  end

  add_index "pending_callsign", ["callsign", "ip"], name: "index_pending_callsign_on_callsign_and_ip", unique: true

  create_table "pending_dvb", force: :cascade do |t|
    t.integer "ip"
    t.integer "transportid"
    t.integer "networkid"
    t.integer "serviceid"
    t.integer "channame"
    t.integer "icon_id"
  end

  add_index "pending_dvb", ["transportid", "networkid", "serviceid", "ip"], name: "pd_index", unique: true

  create_table "pending_xmltvid", force: :cascade do |t|
    t.integer "ip"
    t.text    "xmltvid"
    t.text    "channame"
    t.integer "icon_id"
  end

  add_index "pending_xmltvid", ["xmltvid", "ip"], name: "index_pending_xmltvid_on_xmltvid_and_ip", unique: true

  create_table "sources", force: :cascade do |t|
    t.text "name"
    t.text "url"
  end

  create_table "xmltvids", force: :cascade do |t|
    t.text    "xmltvid"
    t.text    "primary_key"
    t.integer "icon_id"
  end

end
