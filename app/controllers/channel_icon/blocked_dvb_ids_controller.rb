class ChannelIcon::BlockedDvbIdsController < ApplicationController
  def create
    @dvbid = ChannelIcon::BlockedDvbId.new(params[:dvbid])
    @dvbid.save
  end
end
