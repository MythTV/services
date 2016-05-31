require 'test_helper'

class IconTest < ActiveSupport::TestCase
  setup do
    @source = ChannelIcon::Source.find_by_name("Source1")
  end

  test "icon missing sourceid and url" do
    icon = ChannelIcon::Icon.new
    assert_not icon.save
  end
  test "icon missing url" do
    icon = ChannelIcon::Icon.new(source_id: @source.source_id)
    assert_not icon.save, "Failed to save icon #{icon.errors.full_messages}"
  end
  test "icon missing name" do
    icon = ChannelIcon::Icon.new(icon: "path/to/img.png")
    assert_not icon.save
  end
  test "valid icon should save" do
    icon = ChannelIcon::Icon.new(source_id: @source.source_id, icon: "path/to/img.png", enabled: 1, source_tag: "tag", name: "name")
    assert icon.save, "Failed to save icon #{icon.errors.full_messages}"
  end
end
