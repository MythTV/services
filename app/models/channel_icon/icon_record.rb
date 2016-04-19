class ChannelIcon::IconRecord
  attr_accessor :query, :iconID, :iconName, :fullUrl

  def initialize
    @query=""
    @iconID=""
    @iconName=""
    @fullUrl=""
  end
  def find_by_icon_id(id)
    icon = ChannelIcon::Icon.find_by_icon_id(id)
    @iconID = icon.icon_id.to_s
    @iconName = icon.name
    source = ChannelIcon::Source.find_by_source_id(icon.source_id)
    url = source.url + '/' + icon.icon
    @fullUrl = url.sub(%r|logo/hires|, 'hires')
    @icon = self
  end
  def error_callsign
    @fullUrl = "ERROR:  Unknown callsign"
    @icon = self
  end
  def error_xmltvid
    @fullUrl = "ERROR:  Unknown xmltvid"
    @icon = self
  end
end
