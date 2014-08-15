class TeamsController < ApplicationController
  before_action :check_for_user_team, only: [:new, :create]

  def new
    @league = get_league
    @team = Team.new
  end

  def create
    team = @league.teams.create(team_params)
    @league.standings.create(team: team)
    redirect_to @league
  end

  def show
    @team = get_team
  end

  def update
    player = NFLPlayer.find_by(name: params[:player])
    Roster.find_by(team_id: get_team.id, player_id: player.id).toggle_active.save
    render nothing: true, status: 200
  end

  private

  def team_params
    params.require(:team).permit(:name).merge(user_id: current_user.id)
  end

  def get_team
    @team ||= Team.find(params[:id])
  end

  def get_league
    @league ||= League.find(params[:league_id])
  end

  def check_for_user_team
    if get_league.has_user_team?(current_user)
      redirect_to get_league
    end
  end
end
