class ChannelIcon::XmltvidsController < ApplicationController
  def create
    @xmltvid = ChannelIcon::Xmltvid.new(params[:xmltvid])
    @xmltvid.save
  end
end
