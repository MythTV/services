class ChannelIcon::DvbIdsController < ApplicationController
  def create
    @dvb = ChannelIcon::DvbId.new(params[:dvb])
    @dvb.save
  end
end
