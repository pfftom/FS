require "oauth_util"
require "net/http"
require "rexml/document"

class NFLImport
  BASE_URL = "http://fantasysports.yahooapis.com/fantasy/v2"
  PLAYERS_URL = "#{BASE_URL}/games;game_keys=nfl/players"
  MAX_PLAYERS = 1800

  def initialize
    @auth = set_oauth
  end

  def get_all_players
    process_players_xml(get_player_xml)
  end

  private

  def get_data(url)
    parsed_url = URI.parse(url)
    Net::HTTP.start(parsed_url.host) do |http|
      request = Net::HTTP::Get.new "#{ parsed_url.path }?#{ @auth.sign(parsed_url).query_string }"
      REXML::Document.new(http.request(request).body)
    end
  end

  def get_player_xml
    (0..MAX_PLAYERS).step(25).map do |i|
      player_group_url = "#{PLAYERS_URL};start=#{i};count=25"
      get_data(player_group_url)
    end
  end

  def process_players_xml(players_xml)
    players_xml.flat_map do |player_xml|
      format_player_xml(player_xml).map do |player_doc|
        player_hash(player_doc)
      end
    end
  end

  def set_oauth
    auth = OauthUtil.new
    auth.consumer_key = ENV.fetch("YAHOO_KEY")
    auth.consumer_secret = ENV.fetch("YAHOO_SECRET")
    auth
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
