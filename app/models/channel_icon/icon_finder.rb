# This class handles the messy details of how we find icons
# via the various different methods.
class ChannelIcon::IconFinder
  def find_by_callsign(q)
    callsign = ChannelIcon::Callsign.find_by_callsign(q.downcase)
    if !callsign.nil?
      iconQuery = ChannelIcon::IconRecord.new
      iconQuery.query = 'callsign'
      @icon = iconQuery.find_by_icon_id(callsign.icon_id)
    else
      @icon = ChannelIcon::IconRecord.new.error_callsign
    end
  end

  def find_by_xmltvid(q)
    xmltvid = ChannelIcon::Xmltvid.find_by_xmltvid(q)
    if !xmltvid.nil?
      iconQuery = ChannelIcon::IconRecord.new
      iconQuery.query = 'xmltvid'
      @icon = iconQuery.find_by_icon_id(xmltvid.icon_id)
    else
      @icon = ChannelIcon::IconRecord.new.error_xmltvid
    end
  end
end
