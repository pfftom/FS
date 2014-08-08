class League < ActiveRecord::Base
  SPORTS = ["Football"]
  has_many :teams

  validates :name, presence: true
  validates :sport, presence: true, inclusion: { in: SPORTS }

  def has_team?(user)
    teams.where(user_id: user.id).any?
  end
end
