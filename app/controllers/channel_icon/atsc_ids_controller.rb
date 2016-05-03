class ChannelIcon::AtscIdsController < ApplicationController
  def create
    @atsc = ChannelIcon::AtscId.new(params[:atsc])
    @atsc.save
  end
end
