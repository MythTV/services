class ChannelIcon::PendingAtscsController < ApplicationController
  def create
    @atsc = ChannelIcon::PendingAtsc.new(params[:atsc])
    @atsc.save
  end
end
