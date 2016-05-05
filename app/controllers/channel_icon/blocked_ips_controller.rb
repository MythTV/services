class ChannelIcon::BlockedIPsController < ApplicationController
  def create
    @ip = ChannelIcon::BlockedIP.new(params[:ip])
    @ip.save
  end
end
