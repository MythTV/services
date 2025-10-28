class InitialChannelIconDb < ActiveRecord::Migration[5.2]
  def change
    create_table :atsc_ids, id: false do |t|
      t.integer     :transportid
      t.integer     :major_chan
      t.integer     :minor_chan
      t.integer     :icon_id
    end
    add_index :atsc_ids, [:transportid, :major_chan, :minor_chan], unique: true, name: "atsc_idx"

    create_table :blocked_atsc_ids, id: false do |t|
      t.integer     :transportid
      t.integer     :major_chan
      t.integer     :minor_chan
      t.integer     :icon_id
    end
    add_index :blocked_atsc_ids, [:transportid, :major_chan, :minor_chan, :icon_id], unique: true, name: 'b_atsc_idx'

    create_table :blocked_callsigns, id: false do |t|
      t.text        :callsign
      t.integer     :icon_id
    end
    add_index :blocked_callsigns, [:callsign, :icon_id], unique: true, name: "b_callsign_idx"

    create_table :blocked_dvb_ids, id: false do |t|
      t.integer     :transportid
      t.integer     :networkid
      t.integer     :serviceid
      t.integer     :icon_id
    end
    add_index :blocked_dvb_ids, [:transportid, :networkid, :serviceid, :icon_id], unique: true, name: 'b_dvb_idx'

    create_table :blocked_ips, id: false do |t|
      t.primary_key :ip
      t.integer     :expire
      t.integer     :user
      t.integer     :reason
    end

    create_table :blocked_xmltvids, id: false do |t|
      t.text        :xmltvid
      t.integer     :icon_id
    end
    add_index :blocked_xmltvids, [:xmltvid, :icon_id], unique: true, name: "b_xmltvid_idx"

    create_table :callsigns, id: false do |t|
      t.text        :callsign
      t.integer     :icon_id
    end
    add_index :callsigns, [:callsign], unique: true, name: "callsigns_idx"

    create_table :db_vers, id: false do |t|
      t.integer     :vers
    end

    create_table :dvb_ids, id: false do |t|
      t.integer     :transportid
      t.integer     :networkid
      t.integer     :serviceid
      t.integer     :icon_id
    end
    add_index :dvb_ids, [:transportid, :networkid, :serviceid], unique: true, name: "dvb_idx"

    create_table :icons, primary_key: "icon_id" do |t|
      t.integer     :source_id
      t.text        :source_tag
      t.text        :name
      t.text        :icon
      t.boolean     :enabled
    end
    add_index :icons, [:source_id, :source_tag], unique: true

    create_table :pending_atsc, id: false do |t|
      t.integer     :ip
      t.integer     :transportid
      t.integer     :major_chan
      t.integer     :minor_chan
      t.text        :channame
      t.integer     :icon_id
    end
    add_index :pending_atsc, [:transportid, :major_chan, :minor_chan, :ip], unique: true, name: 'pa_idx'

    create_table :pending_callsign, id: false do |t|
      t.integer     :ip
      t.text        :callsign
      t.text        :channame
      t.integer     :icon_id
    end
    add_index :pending_callsign, [:callsign, :ip], unique: true, name: "pc_idx"

    create_table :pending_dvb, id: false do |t|
      t.integer     :ip
      t.integer     :transportid
      t.integer     :networkid
      t.integer     :serviceid
      t.text        :channame
      t.integer     :icon_id
    end
    add_index :pending_dvb, [:transportid, :networkid, :serviceid, :ip], unique: true, name: 'pd_idx'

    create_table :pending_xmltvid do |t|
      t.integer     :ip
      t.text        :xmltvid
      t.text        :channame
      t.integer     :icon_id
    end
    add_index :pending_xmltvid, [:xmltvid, :ip], unique: true, name: "px_idx"

    create_table :sources, id: false do |t|
      t.primary_key :source_id
      t.text    :name
      t.text    :url
    end

    create_table :xmltvids, primary_key: "xmltvid" do |t|
      t.text    :xmltvid
      t.integer :icon_id
    end
    add_index :xmltvids, [:xmltvid], unique: true, name: "xmltvids_idx"
  end
end
