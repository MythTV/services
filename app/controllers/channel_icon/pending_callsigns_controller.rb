class ChannelIcon::PendingCallsignsController < ApplicationController
  def create
    @callsign = ChannelIcon::PendingCallsign.new(params[:callsign])
    @callsign.save
  end
end
