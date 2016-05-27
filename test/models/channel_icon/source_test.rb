require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  test "source missing name and url" do
    source = ChannelIcon::Source.new
    assert_not source.save
  end
  test "source missing url" do
    source = ChannelIcon::Source.new(name: "bob")
    assert_not source.save
  end
  test "source missing name" do
    source = ChannelIcon::Source.new(url: "http://example.com")
    assert_not source.save
  end
  test "valid source should save" do
    source = ChannelIcon::Source.new(name: "bob", url: "http://example.com")
    assert source.save
  end
end
