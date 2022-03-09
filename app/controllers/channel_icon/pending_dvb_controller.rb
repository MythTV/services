class ChannelIcon::PendingDvbController < ApplicationController
  def create
    @dvb = ChannelIcon::PendingDvb.new(params[:dvb])
    @dvb.save
  end
end
