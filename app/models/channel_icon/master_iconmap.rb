# Horrible pile of legacy crap...
class ChannelIcon::MasterIconmap
  attr_reader :callsigntonetworks, :networktourls, :baseurls, :iconmappings
  def buildmap
    @baseurls = []
    sourcemap = {}
    m_sources = ChannelIcon::Source.all
    m_sources.each do |source|
      @baseurls.push({ stub: source.name, url: source.url })
      sourcemap[source.source_id] = source.name # DB query optimization
    end
    callsigns = ChannelIcon::Callsign.all.sort
    @callsigntonetworks = []
    @networktourls = []
    callsigns.each do |callsign|
      icon = ChannelIcon::Icon.find_by_icon_id(callsign.icon_id)
      network = sourcemap[icon.source_id] + '-' + icon.source_tag
      network_url = '[' + sourcemap[icon.source_id] + ']/' + icon.icon
      @callsigntonetworks.push({ callsign: callsign.callsign, network: network })
      @networktourls.push({ network: network, url: network_url })
    end
    @iconmappings = { callsigntonetwork: @callsigntonetworks, networktourl: @networktourls, baseurl: @baseurls }
    return @iconmappings
  end
end
