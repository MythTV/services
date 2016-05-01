class ChannelIcon::PendingCallsign < ActiveRecord::Base
  self.table_name = 'pending_callsign'
  belongs_to  :icon
  validates   :icon, :presence => true
end
