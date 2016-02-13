class ChannelIconController < ApplicationController
  def ping
    render plain:
    # Current service returns time since epoch in seconds
    # but this will do for now, and is nicer
    @current = Time.current()
  end

  def lookup
    @icons = Icon.find('39563')
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
