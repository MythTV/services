xml.instruct!
xml.iconmappings do
  @iconmappings[:callsigntonetwork].each do |callsigntonetwork|
    xml.callsigntonetwork do
      xml.callsign callsigntonetwork[:callsign]
      xml.network  callsigntonetwork[:network]
    end
  end
  @iconmappings[:networktourl].each do |networktourl|
    xml.networktourl do
      xml.network  networktourl[:network]
      xml.url      networktourl[:url]
    end
  end
  @iconmappings[:baseurl].each do |baseurl|
    xml.baseurl do
      xml.stub     baseurl[:stub]
      xml.url      baseurl[:url]
    end
  end
end
