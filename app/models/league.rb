class League < ActiveRecord::Base
  SPORTS = ["Football"]
  has_many :teams, dependent: :destroy
  has_many :users, through: :teams
  has_many :players, through: :teams
  belongs_to :admin, class_name: "User"
  has_many :matchups, dependent: :destroy
  has_many :standings, dependent: :destroy

  validates :name, presence: true
  validates :sport, presence: true, inclusion: { in: SPORTS }

  def sorted_standings
    standings.order("wins DESC")
  end

  def has_user_team?(user)
    users.include?(user)
  end

  def find_team(user)
    teams.find_by(user_id: user.id)
  end

  def drafted_players
    players
  end

  def determine_results
    matchups.where(week: CurrentWeek.week).each do |matchup|
      matchup.calculate_result
    end
  end

  def available_players
    NFLPlayer.standard_rule_players - drafted_players
  end

  def available_qbs
    NFLPlayer.standard_rule_players.where(position: "QB") - drafted_players.where(position: "QB")
  end

  def available_rbs
    NFLPlayer.standard_rule_players.where(position: "RB") - drafted_players.where(position: "RB")
  end

  def available_wrs
    NFLPlayer.standard_rule_players.where(position: "WR") - drafted_players.where(position: "WR")
  end

  def available_tes
    NFLPlayer.standard_rule_players.where(position: "TE") - drafted_players.where(position: "TE")
  end

  def available_defs
    NFLPlayer.standard_rule_players.where(position: "DEF") - drafted_players.where(position: "DEF")
  end

  def available_ks
    NFLPlayer.standard_rule_players.where(position: "K") - drafted_players.where(position: "K")
  end
end
