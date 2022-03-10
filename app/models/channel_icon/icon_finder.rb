# This class handles the messy details of how we find icons
# via the various different methods.
class ChannelIcon::IconFinder
  require 'csv'
  include ChannelName
  def find_by_callsign(q)
    iconQuery = ChannelIcon::IconRecord.new
    iconQuery.query = 'callsign'
    callsign = ChannelIcon::Callsign.find_by_callsign(to_snp(q))
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

  def find_by_atsc_tuple(tsid,major,minor)
    iconQuery = ChannelIcon::IconRecord.new
    iconQuery.query = 'atsc'
    atsc = ChannelIcon::AtscId.find_by_atsc_tuple(tsid,major,minor).first
    if !atsc.nil?
      @icon = iconQuery.find_by_icon_id(atsc.icon_id)
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
      icon = self.find_by_callsign(callsign)
      if icon.found
        icon.chanid = chanid
        @icons.push(icon)
        next
      end
      if (tsid.to_i > 0 && netid.to_i > 0 && serviceid.to_i > 0)
        icon = self.find_by_dvb_tuple(netid,tsid,serviceid)
        if icon.found
          icon.chanid = chanid
          @icons.push(icon)
        end
      end
      if (tsid.to_i > 0 && atscmajor.to_i > 0 && atscminor.to_i > 0)
        icon = self.find_by_atsc_tuple(tsid,atscmajor,atscminor)
        if icon.found
          icon.chanid = chanid
          @icons.push(icon)
        end
      end
    end
    return @icons
  end

  def is_blocked?(q)
    # CSV row contains
    # chanid, name, xmltvid, callsign, transportid, atscmajor, atscminor, networkid, serviceid
    CSV.parse(q) do |query|
      chanid = query[0]; name = query[1]; xmltvid = query[2]; callsign = query[3]; tsid = query[4]
      atscmajor = query[5]; atscminor = query[6]; netid = query[7]; serviceid = query[8]
      if ChannelIcon::BlockedXmltvid.exists?(xmltvid: xmltvid, icon_id: chanid)
        return "xmltvid"
      elsif ChannelIcon::BlockedCallsign.exists?(callsign: callsign, icon_id: chanid)
        return "callsign"
      elsif (tsid.to_i > 0 && netid.to_i > 0 && serviceid.to_i > 0) &&
        ChannelIcon::BlockedDvbId.find_by_dvb_tuple(netid,tsid,serviceid).exists?(icon_id: chanid)
        return "dvb"
      elsif (tsid.to_i > 0 && atscmajor.to_i > 0 && atscminor.to_i > 0) &&
        ChannelIcon::BlockedAtscId.find_by_atsc_tuple(tsid,atscmajor,atscminor).exists?(icon_id: chanid)
        return "atsc"
      end
    end
    return nil
  end

  def is_blocked(icon, csv)
    blockedcsv = '"' + icon.iconID + '",' + csv.to_s
    return is_blocked?(blockedcsv)
  end

  def search(query, csv)
    # csv is used to validate if the icon is blocked or not
    # csv= which has the following data escaped
    # - Name, Xmltvid, Callsign, TransportId, AtscMajorChan, AtscMinorChan,
    # - NetworkId, ServiceId
    @icons = []
    q = to_snp(query)
    ################################
    # Multi pass searching
    # Pass 1: Straight lookup
    records = ChannelIcon::Icon.name_is("#{q}")
    records.each do |icon|
      if !is_blocked(icon, csv)
        @icons.push(icon)
      end
    end
    # Pass 2: Starts with the search string
    records = ChannelIcon::Icon.name_startswith("#{q}").order(:name)
    records.each do |icon|
      if !is_blocked(icon, csv)
        @icons.push(icon)
      end
    end
    # Pass 3: Contains the search string
    records = ChannelIcon::Icon.name_contains("#{q}").order(:name)
    records.each do |icon|
      if !is_blocked(icon, csv)
        @icons.push(icon)
      end
    end
    # Pass 4: Pull apart the search string looking for bits of it,
    # excluding commonly used words and plain numbers
    "#{q}".split.each do |q|
      next if q.match(/^([[:digit:]]+|a|fox|sky|the|tv|channel|sports|one|two|three|four|hd)$/i)
      records = ChannelIcon::Icon.name_contains(q).order(:name)
      records.each do |icon|
        if !is_blocked(icon, csv)
          @icons.push(icon)
        end
      end
    end
    return @icons
  end
end
