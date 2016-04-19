class ChannelIconController < ApplicationController
  require 'csv'
  def ping
    render plain:
    # Current service returns time since epoch in seconds
    # but this will do for now, and is nicer
    @current = Time.current()
  end

  def lookup
    # TODO: validate parameters.
    # TODO: respond with json when requested
    # return the following error when not found
    # "callsign","ERROR:  Unknown callsign","",""
    if params[:callsign]
      @search = 'callsign'
      callsign = ChannelIcon::Callsign.find_by_callsign(params[:callsign].downcase)
      if !callsign.nil?
        iconQuery = ChannelIcon::IconRecord.new
        iconQuery.query = 'callsign'
        @icon = iconQuery.find_by_icon_id(callsign.icon_id)
      else
        @icon = ChannelIcon::IconRecord.new.error_callsign
      end
    end
    if params[:xmltvid]
      @search = 'xmltvid'
      xmltvid = ChannelIcon::Xmltvid.find_by_xmltvid(params[:xmltvid])
      if !xmltvid.nil?
        iconQuery = ChannelIcon::IconRecord.new
        iconQuery.query = 'xmltvid'
        @icon = iconQuery.find_by_icon_id(xmltvid.icon_id)
      else
        @icon = ChannelIcon::IconRecord.new.error_xmltvid
      end
    end
  end

  def check_block
  end

  def find_missing
    # param csv= which has the following data escaped
    # - ChannelId,
    # - Name, Xmltvid, Callsign, TransportId, AtscMajorChan, AtscMinorChan,
    # - NetworkId, ServiceId
    # Multiple requests are separated by '\n'
    if params[:csv] && !params[:csv].empty?
      queries = "#{params[:csv]}".split(/\n/)
      queries.each do |q|
        (chanid, name, xmltvid, callsign, transportid, atscmajor, atscminor, networkid, serviceid) =
          CSV.parse(q)
      end
    end
  end

  def search
    # param s= with a callsign. eg.
    # - s=BBC+One+HD
    # - s=BBC%20One%20HD
    # param csv= which has the following data escaped
    # - Name, Xmltvid, Callsign, TransportId, AtscMajorChan, AtscMinorChan,
    # - NetworkId, ServiceId
    if params[:s] && !params[:s].empty?
      ################################
      # NOTE: This in theory should lookup the callsign table, but the existing
      # code does not do this, so initially implement a compatible lookup
      # - Find the callsigns
      #callsigns = ChannelIcon::Callsign.where("callsign LIKE ?", "%#{params[:s]}%")
      # - Find the icons from the callsigns
      #@icons = ChannelIcon::Icon.find_by_icon_id(callsigns)
      ################################

      ################################
      # Multi pass searching
      # Pass 1: Straight lookup
      @icons = ChannelIcon::Icon.name_is("#{params[:s]}")
      # Pass 2: Starts with the search string
      @icons |= ChannelIcon::Icon.name_startswith("#{params[:s]}").order(:name)
      # Pass 3: Contains the search string
      @icons |= ChannelIcon::Icon.name_contains("#{params[:s]}").order(:name)
      # Pass 4: Pull apart the search string looking for bits of it,
      # excluding commonly used words and plain numbers
      "#{params[:s]}".split.each do |q|
        next if q.match(/([[:digit:]]+|a|fox|sky|the|tv|channel|sports|one|two|three|four|hd)/i)
        @icons |= ChannelIcon::Icon.name_contains(q).order(:name)
      end
    end
    if params[:csv] && !params[:csv].empty?
      (name, xmltvid, callsign, transportid, atscmajor, atscminor, networkid, serviceid) =
        CSV.parse("#{params[:csv]}")
    end
  end

  def master_iconmap
  end

  def submit
  end
end
