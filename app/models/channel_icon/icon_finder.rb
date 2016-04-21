# This class handles the messy details of how we find icons
# via the various different methods.
class ChannelIcon::IconFinder
  require 'csv'
  def find_by_callsign(q)
    iconQuery = ChannelIcon::IconRecord.new
    iconQuery.query = 'callsign'
    callsign = ChannelIcon::Callsign.find_by_callsign(q.downcase)
    if !callsign.nil?
      @icon = iconQuery.find_by_icon_id(callsign.icon_id)
    else
      @icon = iconQuery.error_callsign
    end
  end

  def find_by_xmltvid(q)
    iconQuery = ChannelIcon::IconRecord.new
    iconQuery.query = 'xmltvid'
    xmltvid = ChannelIcon::Xmltvid.find_by_xmltvid(q.downcase)
    if !xmltvid.nil?
      @icon = iconQuery.find_by_icon_id(xmltvid.icon_id)
    else
      @icon = iconQuery.error_xmltvid
    end
  end

  def find_by_dvb_tuple(netid,tsid,serviceid)
    iconQuery = ChannelIcon::IconRecord.new
    iconQuery.query = 'dvb'
    dvb = ChannelIcon::DvbId.find_by_dvb_tuple(netid,tsid,serviceid).first
    if !dvb.nil?
      @icon = iconQuery.find_by_icon_id(dvb.icon_id)
    else
      @icon = iconQuery.not_found
    end
  end

  def find_missing(q)
    # each CSV row contains
    # chanid, name, xmltvid, callsign, transportid, atscmajor, atscminor, networkid, serviceid
    @icons = []
    CSV.parse(q) do |query|
      chanid = query[0]; name = query[1]; xmltvid = query[2]; callsign = query[3]; tsid = query[4]
      atscmajor = query[5]; atscminor = query[6]; netid = query[7]; serviceid = query[8]
      icon = self.find_by_xmltvid(xmltvid) #xmltvid
      if icon.found
        icon.chanid = chanid
        @icons.push(icon)
        next
      end
      if !(tsid == 0 && netid == 0 && serviceid == 0)
        icon = self.find_by_dvb_tuple(netid,tsid,serviceid)
        if icon.found
          icon.chanid = chanid
          @icons.push(icon)
        end
      end
    end
    return @icons
  end
end
