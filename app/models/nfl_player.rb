class NFLPlayer < ActiveRecord::Base
  STANDARD_RULE_POSITIONS = ["QB", "RB", "WR", "TE", "DEF", "K"]
  has_many :stats, dependent: :destroy

  validates :yahoo_key, presence: true, uniqueness: true
  validates :yahoo_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :position, presence: true
  validates :position_type, presence: true

  paginates_per 20

  def position_stats
    stats.where(stat_id: relevant_stat_ids).order(:stat_id)
  end

  def self.quarterbacks
    where(position: "QB")
  end

  def self.backs
    where(position: "RB")
  end

  def self.receivers
    where(position: "WR")
  end

  def self.tight_ends
    where(position: "TE")
  end

  def self.kickers
    where(position: "K")
  end

  def self.defenses
    where(position: "DEF")
  end

  def self.standard_rule_players
    where(position: STANDARD_RULE_POSITIONS)
  end

  private

  def relevant_stat_ids
    PositionStats.const_get(position)
  end
end
