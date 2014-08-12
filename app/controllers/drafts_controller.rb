class DraftsController < ApplicationController
  before_action :check_roster_limit, only: [:create]

  def show
    @draft_presenter = DraftPresenter.new(league)
  end

  def create
    team = league.find_team(current_user)
    player = NFLPlayer.find_by(name: params[:player_name])
    roster = Roster.create(player_id: player.id, team_id: team.id)
    push_selection(player, roster)
    render nothing: true, status: 200
  end

  private

  def league
    @league ||= League.find(params[:league_id])
  end

  def check_roster_limit
    team = league.find_team(current_user)
    if team.players.count >= 15
      redirect_to :show
    end
  end

  def push_selection(player, roster)
    selection_data = {
      selection: render_to_string(roster),
      player_id: player.id,
      selector_id: current_user.id
    }
    DraftPusher.new(league, player, selection_data).make_selection
  end
end
