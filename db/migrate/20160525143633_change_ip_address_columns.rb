class ChangeIpAddressColumns < ActiveRecord::Migration[5.2]
  def change
    # Simply doing a change_column doesn't work as existing data
    # fails the validations.
    #
    # Create replacement tables
    create_table :new_blocked_ips do |t|
      t.integer     :ip, :limit => 8
      t.integer     :expire, :limit => 8
      t.integer     :user
      t.integer     :reason
    end
    create_table :new_pending_atsc do |t|
      t.integer     :ip, :limit => 8
      t.integer     :transportid
      t.integer     :major_chan
      t.integer     :minor_chan
      t.text        :channame
      t.integer     :icon_id
    end
    create_table :new_pending_callsign do |t|
      t.integer     :ip, :limit => 8
      t.text        :callsign
      t.text        :channame
      t.integer     :icon_id
    end
    create_table :new_pending_dvb do |t|
      t.integer     :ip, :limit => 8
      t.integer     :transportid
      t.integer     :networkid
      t.integer     :serviceid
      t.text        :channame
      t.integer     :icon_id
    end
    create_table :new_pending_xmltvid do |t|
      t.integer     :ip, :limit => 8
      t.text        :xmltvid
      t.text        :channame
      t.integer     :icon_id
    end
    # Migrate data to new tables
    execute "INSERT INTO new_blocked_ips (ip, expire, user, reason) select ip, expire, user, reason from blocked_ips;"
    execute "INSERT INTO new_pending_atsc (ip, transportid, major_chan, minor_chan, channame, icon_id) select ip, transportid, major_chan, minor_chan, channame, icon_id from pending_atsc;"
    execute "INSERT INTO new_pending_callsign (ip, callsign, channame, icon_id) select ip, callsign, channame, icon_id from pending_callsign;"
    execute "INSERT INTO new_pending_dvb (ip, transportid, networkid, serviceid, channame, icon_id) select ip, transportid, networkid, serviceid, channame, icon_id from pending_dvb;"
    execute "INSERT INTO new_pending_xmltvid (ip, xmltvid, channame, icon_id) select ip, xmltvid, channame, icon_id from pending_xmltvid;"
    # Drop old tables
    drop_table :blocked_ips
    drop_table :pending_atsc
    drop_table :pending_callsign
    drop_table :pending_dvb
    drop_table :pending_xmltvid
    # Rename new tables
    rename_table :new_blocked_ips, :blocked_ips
    rename_table :new_pending_atsc, :pending_atsc
    rename_table :new_pending_callsign, :pending_callsign
    rename_table :new_pending_dvb, :pending_dvb
    rename_table :new_pending_xmltvid, :pending_xmltvid
    # Re-add indexes
    add_index :pending_atsc, [:transportid, :major_chan, :minor_chan, :ip], unique: true, name: 'pa_idx'
    add_index :pending_callsign, [:callsign, :ip], unique: true, name: "pc_idx"
    add_index :pending_dvb, [:transportid, :networkid, :serviceid, :ip], unique: true, name: 'pd_idx'
    add_index :pending_xmltvid, [:xmltvid, :ip], unique: true, name: "px_idx"
  end
end
