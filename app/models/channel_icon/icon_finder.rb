# This class handles the messy details of how we find icons
# via the various different methods.
class ChannelIcon::IconFinder
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
end
