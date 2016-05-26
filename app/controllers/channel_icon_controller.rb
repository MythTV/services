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
    if @icon.found
      Rails.logger.info "  Found an icon match"
    else
      Rails.logger.info "  No matching icon found"
    end
    if request.format == :html
      request.format = :text
    end
    respond_to :text, :json
  end

  def check_block
    m_Query = ChannelIcon::IconFinder.new
    @blocked = m_Query.is_blocked?("#{params[:csv]}")
    if request.format == :html
      request.format = :text
    end
    respond_to :text
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
    Rails.logger.info "  Found #{@icons.length} icon(s)"
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
      ################################
      m_Query = ChannelIcon::IconFinder.new
      @icons |= m_Query.search("#{params[:s]}","#{params[:csv]}")
    end
    Rails.logger.info "  Found #{@icons.length} icon(s)"
    if request.format == :html
      request.format = :text
    end
    respond_to :text
  end

  def master_iconmap
    m_Query = ChannelIcon::MasterIconmap.new
    @iconmappings = m_Query.buildmap
    if request.format == :html || request.format == :text
      request.format = :xml
    end
    respond_to :xml
  end

  def submit
    if params[:csv] && !params[:csv].empty?
      m_Query = ChannelIcon::IconSubmit.new
      @stats = m_Query.submit("#{params[:csv]}", request.remote_ip)
    end
    Rails.logger.info "  Submitted a:#{@stats[:atsc].to_s}, c:#{@stats[:callsign].to_s}, d:#{@stats[:dvb].to_s}, t:#{@stats[:total].to_s}, x:#{@stats[:xmltvid].to_s} icon(s)"
    if request.format == :html
      request.format = :text
    end
    respond_to :text
  end
end
