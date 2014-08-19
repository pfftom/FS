class RostersController < ApplicationController
  before_action :ensure_user_owns_team, only: [:update, :destroy]
  before_action :ensure_elgible_position, only: [:update]
  before_action :check_roster_limit, only: [:create]

  def create
    player = NFLPlayer.find_by(name: params[:player])
    team.rosters.create(player: player)
    render nothing: true, status: 200
  end

  def update
    roster = Roster.find_by(team_id: team.id, player_id: player.id)
    set_impact(roster)
    render nothing: true
  end

  def destroy
    Roster.find_by(team_id: team.id, player_id: player.id).destroy
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

  def check_roster_limit
    unless team.players.count < 15
      render nothing: true
    end
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
