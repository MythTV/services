require 'httparty'

namespace :picons do
  desc "Load picons mappings"
  task load: :environment do
    snp_url = "https://github.com/picons/picons/raw/master/build-source/snp.index"
    srp_url = "https://github.com/picons/picons/raw/master/build-source/srp.index"
    @stats = {icons: 0, callsigns: 0, dvb: 0}

    s = ChannelIcon::Source.where(name: "picons").first_or_create do |x|
      x.url="https://github.com/picons/picons/raw/master/build-source/logos"
    end

    # Callsign -> SNP (generic name)
    # - https://github.com/picons/picons/blob/master/build-source/snp.index
    # - https://github.com/picons/picons/raw/master/build-source/snp.index
    # Example icon (uses the SNP name)
    # - https://github.com/picons/picons/raw/master/build-source/logos/bbcone.default.svg
    # - https://raw.githubusercontent.com/picons/picons/master/build-source/logos/bbcone.default.svg
    #
    # Fetch SNP mappings
    response = HTTParty.get(snp_url)
    if not response.success?
      Rails.logger.error("Failed to get snp index: #{response.code}")
      return
    end
    snp_records = response.body.split("\n")
    snp_records.each do |row|
      (callsign, snp) = row.split("=")
      icon = ChannelIcon::Icon.where(source_id: s.id, source_tag: snp, name: snp).first_or_create do |ir|
        ir.icon = "#{snp}.default.svg"
        ir.enabled = true
        @stats[:icons] += 1
      end
      print "#{callsign} is #{snp} with iconid #{icon.id}\n"
      cs = ChannelIcon::Callsign.where(callsign: callsign).first_or_create do |c|
        c.icon_id = icon.id
        @stats[:callsigns] += 1
      end
    end

    # ServiceID_TransportID_NetworkID_Namespace -> SNP
    # - https://github.com/picons/picons/blob/master/build-source/srp.index
    # - https://github.com/picons/picons/raw/master/build-source/srp.index
    # What is the Namespace in the SNP?
    # - https://www.linuxsat-support.com/thread/38910-question-on-picon-name-definition/
    #

    # Fetch SRP mappings
    response = HTTParty.get(srp_url)
    if not response.success?
      Rails.logger.error("Failed to get srp index: #{response.code}")
      return
    end
    srp_records = response.body.split("\n")
    srp_records.each do |row|
      (srp, snp) = row.split("=")
      (srp_sid, srp_tsid, srp_netid, srp_namespace) = srp.split("_")
      # Filter bad rows
      next if (srp_sid.nil? || srp_tsid.nil? || srp_netid.nil?)
      sid = srp_sid.to_i(16)
      tsid = srp_tsid.to_i(16)
      netid = srp_netid.to_i(16)
      icon = ChannelIcon::Icon.where(source_id: s.id, source_tag: snp, name: snp).first_or_create do |ir|
        ir.icon = "#{snp}.default.svg"
        ir.enabled = true
        @stats[:icons] += 1
      end
      print "#{snp} at netid #{netid}, transportid #{tsid}, serviceid #{sid} with iconid #{icon.id}\n"
      dvb = ChannelIcon::DvbId.where(serviceid: sid, transportid: tsid, networkid: netid).first_or_create do |d|
        d.icon_id = icon.id
        @stats[:dvb] += 1
      end
    end
    print "Stats: Icons: #{@stats[:icons]}, Callsigns: #{@stats[:callsigns]}, DVB: #{@stats[:dvb]}\n"
  end
end
