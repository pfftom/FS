class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  has_many :rosters, dependent: :destroy
  has_many :players, through: :rosters
end
