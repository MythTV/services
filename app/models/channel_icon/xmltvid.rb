class ChannelIcon::Xmltvid < ActiveRecord::Base
  self.primary_key = 'xmltvid'
  belongs_to  :icon
end
