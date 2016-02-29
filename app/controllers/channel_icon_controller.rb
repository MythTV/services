class ChannelIconController < ApplicationController
  def ping
    render plain:
    # Current service returns time since epoch in seconds
    # but this will do for now, and is nicer
    @current = Time.current()
  end

  def lookup
    if params[:callsign]
      @search = 'callsign'
      callsign = ChannelIcon::Callsign.find_by_callsign(params[:callsign])
      if !callsign.nil?
        @icon = ChannelIcon::Icon.find_by_icon_id(callsign.icon_id)
      end
    end
  end

  def check_block
  end

  def find_missing
  end

  def search
  end

  def master_iconmap
  end

  def submit
  end
end
