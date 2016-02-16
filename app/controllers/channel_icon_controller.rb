class ChannelIconController < ApplicationController
  def ping
    render plain:
    # Current service returns time since epoch in seconds
    # but this will do for now, and is nicer
    @current = Time.current()
  end

  def lookup
    if params[:callsign]
      callsign = ChannelIcon::Callsign.find(params[:callsign])
      @icons = ChannelIcon::Icon.find(callsign.icon_id)
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
