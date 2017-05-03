require 'test_helper'

###################
#I, [2016-05-31T18:03:17.284236 #18053]  INFO -- : Started POST "/channel-icon//findmissing" for 50.189.125.157 at 2016-05-31 18:03:17 +0000
#I, [2016-05-31T18:03:17.285759 #18053]  INFO -- : Processing by ChannelIconController#find_missing as HTML
#I, [2016-05-31T18:03:17.285879 #18053]  INFO -- :   Parameters: {"csv"=>"\"1228\",\"Nickelodeon (Pacific)\",\"11007\",\"NIKP\",\"0\",\"228\",\"0\",\"0\",\"0\"\n"}
#E, [2016-05-31T18:03:17.288143 #18053] ERROR -- : Reference to non existing icon 13566
#I, [2016-05-31T18:03:17.288726 #18053]  INFO -- : Completed 500 Internal Server Error in 3ms (ActiveRecord: 0.4ms)
#F, [2016-05-31T18:03:17.289850 #18053] FATAL -- : 
#NoMethodError (undefined method `found' for true:TrueClass):
#  app/models/channel_icon/icon_finder.rb:57:in `block in find_missing'
############# ^^^^ find_by_xmltvid
#  app/models/channel_icon/icon_finder.rb:53:in `find_missing'
#  app/controllers/channel_icon_controller.rb:65:in `find_missing'
###################

class IconFinderTest < ActiveSupport::TestCase
  test "Invalid Callsign should return not found" do
    iconfinder = ChannelIcon::IconFinder.new
    iconfinder.find_by_callsign("not_found")
    assert_nil iconfinder.instance_variable_get(:@found), "Error when not finding icon #{iconfinder.inspect}"
  end

  test "Find icon by callsign" do
    iconfinder = ChannelIcon::IconFinder.new
    iconfinder.find_by_callsign("icon1")
    assert iconfinder.instance_variable_get(:@icon), "Error finding icon #{iconfinder.inspect}"
  end
end
