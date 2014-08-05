desc "Import NFL players from yahoo, populate players table"
task import_nfl_players: :environment do
  players = NFLImport.new.get_all_players
  players.each do |player|
    NFLPlayer.create(player)
  end
end
