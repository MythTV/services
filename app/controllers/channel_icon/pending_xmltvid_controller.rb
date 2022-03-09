class ChannelIcon::PendingXmltvidController < ApplicationController
  def create
    @xmltvid = ChannelIcon::PendingXmltvids.new(params[:xmltvid])
    @xmltvid.save
  end
end
