class ChannelIcon::Callsign < ActiveRecord::Base
  belongs_to  :icon
  validates   :icon, :presence => true
end
