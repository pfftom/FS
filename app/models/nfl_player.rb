class NFLPlayer < ActiveRecord::Base
  has_many :stats, dependent: :destroy

  validates :yahoo_key, presence: true, uniqueness: true
  validates :yahoo_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :position, presence: true
  validates :position_type, presence: true
end
