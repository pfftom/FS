desc "update nfl_players stats- run this once per week"
task update_nfl_players: :environment do
  players = NFLImport.new(DataImport.new).get_all_players
  players.each do |player|
    nfl_player = NFLPlayer.find_by(yahoo_id: player[0]["yahoo_id"])
    if nfl_player
      nfl_player.update(player[0])
    else
      NFLPlayer.create(player[0])
    end

    player[1].each do |stat|
      statistic = Stat.find_by(stat_id: stat[stat_id], nfl_player_id: nfl_player.id)
      if statistic
        statistic.update(stat)
      else
        Stat.create(stat.merge(nfl_player_id: nfl_player.id))
      end
    end
  end
end
