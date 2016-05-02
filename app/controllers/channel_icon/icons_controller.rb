class ChannelIcon::IconsController < ApplicationController
  def create
    @icon = ChannelIcon::Icon.new(params[:icon])
    @icon.save
  end
end
