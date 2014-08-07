class PlayersController < ApplicationController
  def index
    @qbs = NFLPlayer.quarterbacks.page(params[:qbs])
    @rbs = NFLPlayer.backs.page(params[:rbs])
    @wrs = NFLPlayer.receivers.page(params[:wrs])
    @tes = NFLPlayer.tight_ends.page(params[:tes])
    @defs = NFLPlayer.defenses.page(params[:def])
    @ks = NFLPlayer.kickers.page(params[:ks])
  end
end
