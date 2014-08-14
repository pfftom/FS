class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  has_many :rosters, dependent: :destroy
  has_many :players, through: :rosters
  has_many :active_rosters, -> { where(active: true) }, class_name: "Roster"
  has_many :starters, through: :active_rosters, source: :player
  
  validates :name, presence: true
  validates :user, presence: true
  validates :league, presence: true

  def drop_all_players
    rosters.destroy_all
  end

  def bench
    players - starters
  end

  def can_start?(player)
    pos = player.position
    starters.where(position: pos).count < RosterLimit::MAX_POSITION[pos]
  end

  def under_starter_limit?
    starters.count < RosterLimit::MAX_STARTERS
  end
end
