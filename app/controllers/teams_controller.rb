class TeamsController < ApplicationController
  before_action :check_for_user_team, only: [:new, :create]

  def new
    @league = get_league
    @team = Team.new
  end

  def create
    league = get_league
    league.teams.create(team_params)
    redirect_to league
  end

  private

  def team_params
    params.require(:team).permit(:name).merge(user_id: current_user.id)
  end

  def get_league
    League.find(params[:league_id])
  end

  def check_for_user_team
    unless !get_league.has_team?(current_user)
      redirect_to get_league
    end
  end
end
