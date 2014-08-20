class PlayerTransaction < ActiveRecord::Base
  belongs_to :league
  belongs_to :team

  validates :league, presence: true
  validates :team, presence: true
  validates :action, presence: true
  validates :player, presence: true
end
