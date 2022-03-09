class ChannelIcon::PendingAtscController < ApplicationController
  def create
    @atsc = ChannelIcon::PendingAtsc.new(params[:atsc])
    @atsc.save
  end
end
