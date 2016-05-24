class ChannelIcon::Source < ActiveRecord::Base
  has_many :icons
  validates :name, presence: true
  validates :url, presence: true
end
