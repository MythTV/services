class ChannelIcon::PendingDvb < ActiveRecord::Base
  self.table_name = 'pending_dvb'
  belongs_to  :icon
  validates   :icon, :presence => true
end
