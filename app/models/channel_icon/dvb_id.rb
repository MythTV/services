class ChannelIcon::DvbId < ActiveRecord::Base
  self.primary_key = 'networkid'
  belongs_to  :icon
  validates   :icon, :presence => true
  
  scope :find_by_dvb_tuple, ->(netid,tsid,serviceid) {
      where("networkid = ? and transportid = ? and serviceid = ?",
        "#{netid}", "#{tsid}", "#{serviceid}")
    }
end
