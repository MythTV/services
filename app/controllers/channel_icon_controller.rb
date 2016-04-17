class ChannelIconController < ApplicationController
  def ping
    render plain:
    # Current service returns time since epoch in seconds
    # but this will do for now, and is nicer
    @current = Time.current()
  end

  def lookup
    # TODO: validate parameters.
    if params[:callsign]
      @search = 'callsign'
      callsign = ChannelIcon::Callsign.find_by_callsign(params[:callsign].downcase)
      if !callsign.nil?
        @icon = ChannelIcon::Icon.find_by_icon_id(callsign.icon_id)
      end
    end
    if params[:xmltvid]
      @search = 'xmltvid'
      xmltvid = ChannelIcon::Xmltvid.find_by_xmltvid(params[:xmltvid])
      if !xmltvid.nil?
        @icon = ChannelIcon::Icon.find_by_icon_id(xmltvid.icon_id)
      else
        # return the following error when not found
        # "xmltvid","ERROR:  Unknown xmltvid","",""
        erroricon = ChannelIcon::Icon.new
        erroricon.source_id = -1
        erroricon.icon_id = ""
        erroricon.name = ""
        @icon = erroricon
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
  end

  def master_iconmap
  end

  def submit
  end
end
