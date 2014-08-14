class DraftsController < ApplicationController
  before_action :check_roster_limit, only: [:create]

  def show
    @draft_presenter = DraftPresenter.new(league)
    @league = league
    @team = league.find_team(current_user)
  end

  def create
    team = league.find_team(current_user)
    player = NFLPlayer.find_by(name: params[:player_name])
    roster = Roster.create(player_id: player.id, team_id: team.id)
    push_selection(player, roster, pick_number(team))
    render nothing: true, status: 200
  end

  def update
    pick = params[:pick].to_i
    draft.next_pick(pick)
    render nothing: true, status: 200
  end

  private

  def league
    @league ||= League.find(params[:league_id])
  end

  def draft
    @draft ||= Draft.new(league)
  end

  def teams
    @teams ||= league.teams.order("id ASC")
  end

  def pick_number(team)
    teams.index(team)
  end

  def check_roster_limit
    team = league.find_team(current_user)
    if team.players.count >= 15
      render nothing: true
    end
  end

  def push_selection(player, roster, pick_id)
    selection_data = {
      selection: render_to_string(roster),
      player_id: player.id,
      selector_id: current_user.id,
      pick_id: pick_id
    }
    DraftPusher.new(league, player, selection_data).make_selection
  end
end
