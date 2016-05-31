require 'test_helper'

class IconRecordTest < ActiveSupport::TestCase
  test "Invalid ID should return not found" do
    iconrecord = ChannelIcon::IconRecord.new
    iconrecord.find_by_icon_id(99999)
    assert iconrecord.instance_variable_get(:@found) == false, "Error when not finding icon #{iconrecord.inspect}"
  end
end
