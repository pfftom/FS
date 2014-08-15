class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def new
    @league = League.new
  end

  def create
    league = League.create(league_params.merge(admin_id: current_user.id))
    redirect_to :leagues
  end

  def show
    @league = League.find(params[:id])
    @standings = @league.sorted_standings
  end

  private

  def league_params
    params.require(:league).permit(:name, :sport)
  end
end
