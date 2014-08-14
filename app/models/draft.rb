class Draft
  def initialize(league)
    league.update(drafted: true)
    @league = league
    @teams = league.teams.order("id ASC");
  end

  def next_pick(pick_number)
    @pick = pick_number
    check_pick
    go_to_next_picker(teams[@pick])
  end

  private

  attr_reader :league, :teams

  def check_pick
    if @pick >= teams.count
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
end
