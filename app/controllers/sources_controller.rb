class SourcesController < ApplicationController
  def index
    @source = Source.all
  end
  def create
    @source = Source.new(params[:source])
    @source.save
  end
end
