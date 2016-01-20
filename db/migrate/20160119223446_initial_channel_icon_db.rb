class InitialChannelIconDb < ActiveRecord::Migration
  def change
    create_table :atsc_ids do |t|
      t.integer     :transportid
      t.integer     :major_chan
      t.integer     :minor_chan
      t.integer     :icon_id
    end
    add_index :atsc_ids, [:transportid, :major_chan, :minor_chan], unique: true

    create_table :blocked_atsc_ids do |t|
      t.integer     :transportid
      t.integer     :major_chan
      t.integer     :minor_chan
      t.integer     :icon_id
    end
    add_index :blocked_atsc_ids, [:transportid, :major_chan, :minor_chan, :icon_id], unique: true, name: 'b_atsc_index'

    create_table :blocked_callsigns do |t|
      t.text        :callsign
      t.integer     :icon_id
    end
    add_index :blocked_callsigns, [:callsign, :icon_id], unique: true

    create_table :blocked_dvb_ids do |t|
      t.integer     :transportid
      t.integer     :networkid
      t.integer     :serviceid
      t.integer     :icon_id
    end
    add_index :blocked_dvb_ids, [:transportid, :networkid, :serviceid, :icon_id], unique: true, name: 'b_dvb_index'

    create_table :blocked_ips do |t|
      t.integer     :ip
      t.integer     :expire
      t.integer     :user
      t.integer     :reason
    end

    create_table :blocked_xmltvids do |t|
      t.text        :xmltvid
      t.integer     :icon_id
    end

    create_table :callsigns do |t|
      t.text        :callsign, :primary_key
      t.integer     :icon_id
    end

    create_table :dvb_ids do |t|
      t.integer     :transportid
      t.integer     :networkid
      t.integer     :serviceid
      t.integer     :icon_id
    end
    add_index :dvb_ids, [:transportid, :networkid, :serviceid], unique: true

    create_table :icons do |t|
      t.integer     :source_id
      t.text        :source_tag
      t.text        :name
      t.text        :icon
      t.boolean     :enabled
    end
    add_index :icons, [:source_id, :source_tag], unique: true

    create_table :pending_atsc do |t|
      t.integer     :ip
      t.integer     :transportid
      t.integer     :major_chan
      t.integer     :minor_chan
      t.text        :channame
      t.integer     :icon_id
    end
    add_index :pending_atsc, [:transportid, :major_chan, :minor_chan, :ip], unique: true, name: 'pa_index'

    create_table :pending_callsign do |t|
      t.integer     :ip
      t.text        :callsign
      t.text        :channame
      t.integer     :icon_id
    end
    add_index :pending_callsign, [:callsign, :ip], unique: true

    create_table :pending_dvb do |t|
      t.integer     :ip
      t.integer     :transportid
      t.integer     :networkid
      t.integer     :serviceid
      t.integer     :channame
      t.integer     :icon_id
    end
    add_index :pending_dvb, [:transportid, :networkid, :serviceid, :ip], unique: true, name: 'pd_index'

    create_table :pending_xmltvid do |t|
      t.integer     :ip
      t.text        :xmltvid
      t.text        :channame
      t.integer     :icon_id
    end
    add_index :pending_xmltvid, [:xmltvid, :ip], unique: true

    create_table :sources do |t|
      t.text    :name
      t.text    :url
    end

    create_table :xmltvids do |t|
      t.text    :xmltvid, :primary_key
      t.integer :icon_id
    end
  end
end
