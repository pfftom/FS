class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def new
    @league = League.new
  end

  def create
    league = League.create(league_params)
    redirect_to :leagues
  end

  private

  def league_params
    params.require(:league).permit(:name, :sport)
  end
end
