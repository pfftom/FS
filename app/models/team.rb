class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  has_many :rosters, dependent: :destroy
  has_many :players, through: :rosters

  validates :name, presence: true
  validates :user, presence: true
  validates :league, presence: true

  def drop_all_players
    rosters.destroy_all
  end
end
