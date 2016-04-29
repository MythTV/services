class ChannelIcon::BlockedAtscId < ActiveRecord::Base
  self.primary_key = 'transportid'
  belongs_to  :icon
  validates   :icon, :presence => true
  
  scope :find_by_atsc_tuple, ->(tsid,major,minor) {
      where("transportid = ? and major_chan = ? and minor_chan = ?",
        "#{tsid}", "#{major}", "#{minor}")
    }
end
