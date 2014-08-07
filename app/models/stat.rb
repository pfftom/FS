class Stat < ActiveRecord::Base
  validates :nfl_player_id, presence: true
  validates :name, presence: true
  validates :stat_id, presence: true
end
