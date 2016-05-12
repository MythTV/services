class ChannelIcon::IconSubmit
  require 'csv'
  require 'ipaddr'
  def submit(csv, ip_in)
    # TODO: Blocked ip / icon etc support
    # Statistics
    @stats = {atsc: 0, callsign: 0, dvb: 0, total: 0, xmltvid: 0}
    ip = IPAddr.new(ip_in)
    # each CSV row contains
    # iconid, name, xmltvid, callsign, transportid, atscmajor, atscminor, networkid, serviceid
    CSV.parse("#{csv}") do |query|
      iconid = query[0]; name = query[1]; xmltvid = query[2]; callsign = query[3]; tsid = query[4]
      atscmajor = query[5]; atscminor = query[6]; netid = query[7]; serviceid = query[8]
      @stats[:total] += 1
      if !callsign.empty? &&
        !ChannelIcon::PendingCallsign.exists?(icon_id: iconid, callsign: callsign, channame: name, ip: ip.to_i)
          icon = ChannelIcon::PendingCallsign.create(icon_id: iconid, callsign: callsign, channame: name, ip: ip.to_i)
          if icon.valid?
            icon.save
            @stats[:callsign] += 1
          end
      end
      if !xmltvid.empty? &&
        !ChannelIcon::PendingXmltvid.exists?(icon_id: iconid, xmltvid: xmltvid, channame: name, ip: ip.to_i)
          icon = ChannelIcon::PendingXmltvid.create(icon_id: iconid, xmltvid: xmltvid, channame: name, ip: ip.to_i)
          if icon.valid?
            icon.save
            @stats[:xmltvid] += 1
          end
      end
      if (tsid.to_i > 0 && netid.to_i > 0 && serviceid.to_i > 0) &&
        !ChannelIcon::PendingDvb.exists?(icon_id: iconid, transportid: tsid, networkid: netid,
          serviceid: serviceid, channame: name, ip: ip.to_i)
          icon = ChannelIcon::PendingDvb.create(icon_id: iconid, transportid: tsid, networkid: netid,
            serviceid: serviceid, channame: name, ip: ip.to_i)
          if icon.valid?
            icon.save
            @stats[:dvb] += 1
          end
      end
      if (tsid.to_i > 0 && atscmajor.to_i > 0 && atscminor.to_i > 0) &&
        !ChannelIcon::PendingAtsc.exists?(icon_id: iconid, transportid: tsid, major_chan: atscmajor,
          minor_chan: atscminor, channame: name, ip: ip.to_i)
          icon = ChannelIcon::PendingAtsc.create(icon_id: iconid, transportid: tsid, major_chan: atscmajor,
            minor_chan: atscminor, channame: name, ip: ip.to_i)
          if icon.valid?
            icon.save
            @stats[:atsc] += 1
          end
      end
    end
    return @stats
  end
end
