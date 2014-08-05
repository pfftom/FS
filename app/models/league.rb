class League < ActiveRecord::Base
  SPORTS = ["Football"]

  validates :name, presence: true
  validates :sport, presence: true, inclusion: { in: SPORTS }
end
