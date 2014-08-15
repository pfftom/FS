class MatchCreate
  def initialize(league)
    @league = league
    @teams = league.teams.shuffle
  end

  def new_matchups
    while @teams.any? && @teams.count % 2 == 0
      match = @teams.pop(2)
      create_matchups(match_params(match))
    end
  end

  private

  def create_matchups(match)
    @league.matchups.create(match)
  end

  def match_params(match)
    {
      home_team: match[0],
      away_team: match[1],
      week: CurrentWeek.week
    }
  end
end
