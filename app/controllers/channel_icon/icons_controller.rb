class ChannelIcon::IconsController < ApplicationController
  def create
    @icon = ChannelIcon::Icon.new(params[:callsign])
    @icon.save
  end
end
