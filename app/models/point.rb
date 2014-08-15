class Point < ActiveRecord::Base
  validates :nfl_player, presence: true
  validates :value, presence: true
end
