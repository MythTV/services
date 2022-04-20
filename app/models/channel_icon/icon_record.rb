class ChannelIcon::IconRecord
  attr_accessor :query, :iconID, :iconName, :fullUrl, :chanid
  attr_reader   :found

  require 'json'

  def as_json(options={})
    {
      query:    @query,
      iconID:   @iconID,
      iconName: @iconName,
      fullUrl:  @fullUrl,
      chanid:   @chanid
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def initialize
    @query=""
    @iconID=""
    @iconName=""
    @fullUrl=""
    @chanid=""
    @found=true
  end

  # Finder methods
  def find_by_icon_id(id)
    icon = ChannelIcon::Icon.find_by_icon_id(id)
    if icon.nil?
      @icon = self.not_found
      Rails.logger.error "Reference to non existing icon #{id}"
    else
      @iconID = icon.icon_id.to_s
      @iconName = icon.name
      @fullUrl = self.to_fullUrl(icon.source_id, icon.icon)
      @icon = self
    end
  end

  # Error methods
  def error_callsign
    @fullUrl = "ERROR:  Unknown callsign"
    @found = false
    @icon = self
  end
  def error_xmltvid
    @fullUrl = "ERROR:  Unknown xmltvid"
    @found = false
    @icon = self
  end
  def not_found
    @found = false
    @icon = self
  end

  # Helper methods
  protected
  def to_fullUrl(source_id, icon)
    source = ChannelIcon::Source.find_by_source_id(source_id)
    url = source.url + '/' + icon
    @fullUrl = url.sub(%r|icon/tv|, 'hires')
    @fullUrl = url.sub(%r|logo/tv|, 'hires')
  end
end
