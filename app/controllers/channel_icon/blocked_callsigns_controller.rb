class ChannelIcon::BlockedCallsignsController < ApplicationController
  def create
    @callsign = ChannelIcon::BlockedCallsign.new(params[:callsign])
    @callsign.save
  end
end
