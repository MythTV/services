class Samples::VideoController < ApplicationController
  def index
    if params[:sample] == "HD"
      redirect_to 'http://ftp.osuosl.org/pub/mythtv/samples/videos/mythtv_video_test_HD_19000Kbps_H264.mkv'
    elsif params[:sample] == "SD"
      redirect_to 'http://ftp.osuosl.org/pub/mythtv/samples/videos/mythtv_video_test_SD_6000Kbps_H264.mkv'
    else
      redirect_to 'https://www.mythtv.org'
    end
  end
end
