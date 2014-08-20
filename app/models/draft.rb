class Draft
  PICKS_PER_TEAM = 15

  def initialize(league)
    league.update(drafted: true)
    @league = league
    @teams = set_draft_order
  end

  def next_pick(pick_number)
    @pick = pick_number
    check_pick
    create_or_update_pick(teams[@pick])
    go_to_next_picker(teams[@pick])
  end

  private

  attr_reader :league, :teams

  def create_or_update_pick(team)
    current_pick = CurrentDraftPick.find_or_create_by(league_id: league.id)
    current_pick.update(pick_index: @pick, team: team.name)
  end

  def check_pick
    if @pick >= teams.count
      league.current_draft_pick.update(pick_index: 0, team: "")
      @pick = 0
    end
  end

  def go_to_next_picker(team)
    league.users.each do |user|
      Pusher[user.id].trigger("on_the_clock", {
        team: team.name,
        pick: @pick
      })
    end
  end

  def set_draft_order
    teams = league.teams.order("id ASC")
    draft_order = teams + teams.reverse_order
    draft_order *= 15
  end
end
