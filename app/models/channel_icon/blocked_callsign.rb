class ChannelIcon::BlockedCallsign < ActiveRecord::Base
  belongs_to  :icon
  validates   :icon, :presence => true
end
