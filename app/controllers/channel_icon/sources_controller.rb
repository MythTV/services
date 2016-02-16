class ChannelIcon::SourcesController < ApplicationController
  def index
    @source = ChannelIcon::Source.all
  end
  def create
    @source = ChannelIcon::Source.new(params[:source])
    @source.save
  end
end
