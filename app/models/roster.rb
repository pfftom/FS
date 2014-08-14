class Roster < ActiveRecord::Base
  validates :player, presence: true
  validates :team, presence: true

  belongs_to :player, class_name: "NFLPlayer"
  belongs_to :team

  def toggle_active
    toggle(:active)
  end
end
