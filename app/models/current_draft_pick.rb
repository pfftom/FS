class CurrentDraftPick < ActiveRecord::Base
  belongs_to :league
  validates :league, presence: true, uniqueness: true
end
