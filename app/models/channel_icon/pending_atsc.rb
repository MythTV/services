class ChannelIcon::PendingAtsc < ActiveRecord::Base
  self.table_name = 'pending_atsc'
  belongs_to  :icon
  validates   :icon, :presence => true
end
