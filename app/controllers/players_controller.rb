class PlayersController < ApplicationController
  def index
    presenter = PlayersPresenter.new(league)
    @qbs = presenter.qbs.page(params[:qbs])
    @rbs = presenter.rbs.page(params[:rbs])
    @wrs = presenter.wrs.page(params[:wrs])
    @tes = presenter.tes.page(params[:tes])
    @defs = presenter.defs.page(params[:def])
    @ks = presenter.ks.page(params[:ks])
    @league = league
    @team = league.find_team(current_user)
  end

  private

  def league
    @league ||= League.find_by(id: params[:league_id])
  end
end
