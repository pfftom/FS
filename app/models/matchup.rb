class Matchup < ActiveRecord::Base
  belongs_to :away_team, class_name: "Team"
  belongs_to :home_team, class_name: "Team"

  def calculate_result
    update(winning_team_id: determine_winner)
  end

  private

  def determine_winner
    if away_team.points > home_team.points
      away_team.mark_as_won
      home_team.mark_as_lost
      away_team.id
    elsif home_team.points > away_team.points
      home_team.mark_as_won
      away_team.mark_as_lost
      home_team.id
    else
      home_team.mark_as_tied
      away_team.mark_as_tied
      0
    end
  end
end
