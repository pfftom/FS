class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  has_many :rosters, dependent: :destroy
  has_many :players, through: :rosters
  has_many :active_rosters, -> { where(active: true) }, class_name: "Roster"
  has_many :starters, through: :active_rosters, source: :player
  has_one :standing, dependent: :destroy
  has_one :impact_roster, -> { where(impact: true) }, class_name: "Roster"
  has_one :impact_player, through: :impact_roster, source: :player
  has_many :player_transactions, dependent: :destroy
  
  validates :name, presence: true
  validates :user, presence: true
  validates :league, presence: true

  def matchups
    Matchup.where("away_team_id = ? OR home_team_id = ?", id, id)
  end

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

  def points(week = CurrentWeek.week)
    starters.inject(0) do |sum, starter|
      if starter == impact_player
        sum + starter.weekly_points(week) * 2
      else
        sum + starter.weekly_points(week)
      end
    end
  end

  def mark_as_won
    standing.increment!(:wins)
  end

  def mark_as_lost
    standing.increment!(:losses)
  end

  def mark_as_tied
    standing.increment!(:ties)
  end
end
