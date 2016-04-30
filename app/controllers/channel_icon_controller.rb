class ChannelIconController < ApplicationController
  skip_before_action :verify_authenticity_token  # else POST requests to the API fail CSRF checks
  require 'csv'
  def ping
    # Current service returns time since epoch in seconds
    # but this will do for now, and is nicer
    @current = Time.current()
    if request.format == :html
      request.format = :text
    end
    respond_to :text
  end

  def lookup
    # TODO: validate parameters.
    if params[:callsign]
      m_Query = ChannelIcon::IconFinder.new
      @icon = m_Query.find_by_callsign(params[:callsign])
    end
    if params[:xmltvid]
      m_Query = ChannelIcon::IconFinder.new
      @icon = m_Query.find_by_xmltvid(params[:xmltvid])
    end
    if params[:networkid] && params[:transportid] && params[:serviceid]
      m_Query = ChannelIcon::IconFinder.new
      @icon = m_Query.find_by_dvb_tuple("#{params[:networkid]}",
                                        "#{params[:transportid]}",
                                        "#{params[:serviceid]}")
    end
    if params[:transportid] && params[:atsc_major_chan] && params[:atsc_minor_chan]
      m_Query = ChannelIcon::IconFinder.new
      @icon = m_Query.find_by_atsc_tuple("#{params[:transportid]}",
                                         "#{params[:atsc_major_chan]}",
                                         "#{params[:atsc_minor_chan]}")
    end
    if request.format == :html
      request.format = :text
    end
    respond_to :text, :json
  end

  def check_block
  end

  def find_missing
    # param csv= which has the following data escaped
    # - ChannelId,
    # - Name, Xmltvid, Callsign, TransportId, AtscMajorChan, AtscMinorChan,
    # - NetworkId, ServiceId
    # Multiple requests are separated by '\n'
    @icons = []
    if params[:csv] && !params[:csv].empty?
      m_Query = ChannelIcon::IconFinder.new
      @icons |= m_Query.find_missing("#{params[:csv]}")
    end
    if request.format == :html
      request.format = :text
    end
    respond_to :text
  end

  def search
    # param s= with a callsign. eg.
    # - s=BBC+One+HD
    # - s=BBC%20One%20HD
    # param csv= which has the following data escaped
    # - Name, Xmltvid, Callsign, TransportId, AtscMajorChan, AtscMinorChan,
    # - NetworkId, ServiceId
    @icons = []
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
      @icons |= ChannelIcon::Icon.name_is("#{params[:s]}")
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
    if request.format == :html
      request.format = :text
    end
    respond_to :text
  end

  def master_iconmap
    m_Query = ChannelIcon::MasterIconmap.new
    @iconmappings = m_Query.buildmap
  end

  def submit
  end
end
