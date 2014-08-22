class NFLImport
  BASE_URL = "http://fantasysports.yahooapis.com/fantasy/v2"
  PLAYERS_URL = "#{BASE_URL}/games;game_keys=273/players"
  MAX_PLAYERS = 1800

  def initialize(data_import)
    @data_import = data_import
  end

  def get_all_players
    process_players_xml(get_player_xml)
  end

  private

  def get_player_xml
    (0..MAX_PLAYERS).step(25).map do |i|
      player_group_url = "#{PLAYERS_URL};start=#{i};count=25/stats;type=week;week=#{CurrentWeek.week}"
      @data_import.get_data(player_group_url)
    end
  end

  def process_players_xml(players_xml)
    players_xml.flat_map do |player_xml|
      format_player_xml(player_xml).map do |player_doc|
        [player_hash(player_doc), stat_hashes(player_doc)]
      end
    end
  end

  def stat_hashes(player)
    stats = format_stats(player)
    stats.map do |stat|
      { stat_id: stat[0], value: stat[1], name: find_stat_name(stat[0]) }
    end
  end

  def find_stat_name(id)
    StatCategory.find_by(stat_id: id).name
  end

  def format_stats(xml)
    xml.elements.to_a("player_stats/stats/stat").map do |stat|
      [stat.elements["stat_id"].text.to_i, stat.elements["value"].text.to_i]
    end
  end

  def player_hash(player_doc)
    {
      yahoo_key: player_doc.elements["player_key"].text,
      yahoo_id: player_doc.elements["player_id"].text,
      name: player_doc.elements["name"].elements["full"].text,
      team: player_doc.elements["editorial_team_abbr"].text,
      position: player_doc.elements["display_position"].text,
      position_type: player_doc.elements["position_type"].text,
      bye: player_doc.elements["bye_weeks"].elements["week"].text.to_i,
      avatar_url: player_doc.elements["image_url"].text
    }
  end

  def format_player_xml(xml)
    xml.elements.to_a("fantasy_content/games/game/players/player")
  end
end
