class RostersController < ApplicationController
  before_action :ensure_user_owns_team, only: [:update, :destroy]
  before_action :ensure_elgible_position, only: [:update]

  def update
    roster = Roster.find_by(team_id: team.id, player_id: player.id)
    set_impact(roster)
    render nothing: true
  end

  private

  def team
    @_team ||= Team.find(params[:team_id])
  end

  def player
    @_player ||= team.players.find_by(name: params[:player])
  end

  def set_impact(roster)
    if team.impact_roster
      team.impact_roster.update(impact: false)
    end
    roster.update(impact: true)
  end

  def ensure_user_owns_team
    unless current_user == team.user
      render nothing: true
    end
  end

  def ensure_elgible_position
    unless player.position != "QB"
      render nothing: true
    end
  end
end
