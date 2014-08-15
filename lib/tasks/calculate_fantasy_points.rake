desc "calculate fantasy points for each player"
task calculate_fantasy_points: :environment do
  NFLPlayer.all.each do |player|
    points = 0
    player.stats.each do |stat|
      multiplier = PositionStats::STAT_VALUES[stat.stat_id] || 0
      points += stat.value * multiplier
    end
    Point.create(nfl_player_id: player.id, value: points, week: CurrentWeek.week)
  end

  League.all.each do |league|
    league.determine_results
  end

  CurrentWeek.increment_week
end
