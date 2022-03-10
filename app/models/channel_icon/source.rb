class ChannelIcon::Source < ActiveRecord::Base
  self.primary_key = 'source_id'

  has_many :icons
  validates :name, presence: true
  validates :url, presence: true
end
