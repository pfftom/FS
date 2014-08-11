class Roster < ActiveRecord::Base
  validates :player, uniqueness: true, presence: true
  validates :team, presence: true

  belongs_to :player, class_name: "NFLPlayer"
end
