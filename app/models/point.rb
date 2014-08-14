class Point < ActiveRecord::Base
  belongs_to :nfl_player

  validates :nfl_player, presence: true
  validates :value, presence: true
end
