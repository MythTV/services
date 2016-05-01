class ChannelIcon::PendingXmltvid < ActiveRecord::Base
  self.table_name = 'pending_xmltvid'
  belongs_to  :icon
  validates   :icon, :presence => true
end
