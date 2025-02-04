class Music::DataController < ApplicationController
  def index
    if params[:data] == "streams"
      redirect_to 'http://ftp2.osuosl.org/pub/mythtv/music/db/streams.gz'
    else
      redirect_to 'https://www.mythtv.org'
    end
  end
end
