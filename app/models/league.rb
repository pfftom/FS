class League < ActiveRecord::Base
  SPORTS = ["Football"]
  has_many :teams, dependent: :destroy
  has_many :users, through: :teams

  validates :name, presence: true
  validates :sport, presence: true, inclusion: { in: SPORTS }

  def has_user_team?(user)
    users.include?(user)
  end

  def find_team(user)
    teams.find_by(user_id: user.id)
  end
end
