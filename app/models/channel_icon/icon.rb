class ChannelIcon::Icon < ActiveRecord::Base
  self.primary_key = 'icon_id'
  belongs_to    :source
  has_many      :callsigns

  def fullUrl
    source = ChannelIcon::Source.find_by_source_id(self.source_id)
    @fullUrl = source.url + '/' + self.icon
  end
  def iconID
    @iconID = self.icon_id.to_s
  end
  def iconName
    @iconName = self.name
  end
end
