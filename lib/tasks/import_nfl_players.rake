desc "Import NFL players from yahoo, populate players table"
task import_nfl_players: :environment do
  players = NFLImport.new(DataImport.new).get_all_players
  players.each do |player|
    p = NFLPlayer.create(player[0])
    player[1].each do |stat|
      Stat.create(stat.merge(nfl_player_id: p.id))
    end
  end
end
