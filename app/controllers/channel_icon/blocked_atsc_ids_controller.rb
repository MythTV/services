class ChannelIcon::BlockedAtscIdsController < ApplicationController
  def create
    @atscid = ChannelIcon::BlockedAtscId.new(params[:atscid])
    @atscid.save
  end
end
