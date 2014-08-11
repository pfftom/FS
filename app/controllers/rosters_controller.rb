class RostersController < ApplicationController
  def create
    team = league.find_team(current_user)
    player = NFLPlayer.find_by(name: params[:player_name])
    Roster.create(player_id: player.id, team_id: team.id)
    redirect_to root_path
  end

  private

  def league
    League.find(params[:league_id])
  end
end
