class ChannelIcon::CallsignsController < ApplicationController
  def create
    @callsign = ChannelIcon::Callsign.new(params[:callsign])
    @callsign.save
  end
end
