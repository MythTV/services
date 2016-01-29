class SourceController < ApplicationController
  def create
    @source = Source.new(params[:source])
    @source.save
  end
end
