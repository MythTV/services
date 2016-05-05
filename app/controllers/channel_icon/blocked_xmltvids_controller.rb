class ChannelIcon::BlockedXmltvidsController < ApplicationController
  def create
    @xmltvid = ChannelIcon::BlockedXmltvid.new(params[:xmltvid])
    @xmltvid.save
  end
end
