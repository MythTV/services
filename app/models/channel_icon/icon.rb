class ChannelIcon::Icon < ActiveRecord::Base
  self.primary_key = 'icon_id'
  belongs_to    :source
  has_many      :callsigns
  has_many      :xmltvids

  scope :name_contains, ->(name) { where("enabled = 1 AND name LIKE ?", "%#{name}%") }
  scope :name_is, ->(name) { where("enabled = 1 AND name = ?", "#{name}") }
  scope :name_startswith, ->(name) { where("enabled = 1 AND name LIKE ?", "#{name}%") }

  def fullUrl
    if(self.source_id == -1)
      @fullUrl = "ERROR:  Unknown xmltvid"
    else
      source = ChannelIcon::Source.find_by_source_id(self.source_id)
      url = source.url + '/' + self.icon
      @fullUrl = url.sub(%r|logo/hires|, 'hires')
    end
  end
  def iconID
    @iconID = self.icon_id.to_s
  end
  def iconName
    @iconName = self.name
  end
end
