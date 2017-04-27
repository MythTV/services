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
  test "Invalid ID should return not found" do
    iconfinder = ChannelIcon::IconFinder.new
#    iconrecord.find_by_icon_id(99999)
#    assert iconrecord.instance_variable_get(:@found) == false, "Error when not finding icon #{iconrecord.inspect}"
  end
end
