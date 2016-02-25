class ChannelIcon::Callsign < ActiveRecord::Base
  def fullUrl
    icon = ChannelIcon::Icon.find_by_icon_id(self.icon_id)
    source = ChannelIcon::Source.find_by_source_id(icon.source_id)
    @fullUrl = source.url + '/' + icon.icon
  end
  def iconID
    icon = ChannelIcon::Icon.find_by_icon_id(self.icon_id)
    @iconID = icon.icon_id.to_s
  end
  def iconName
    icon = ChannelIcon::Icon.find_by_icon_id(self.icon_id)
    @iconName = icon.name
  end
end
