desc "Import nfl stat categories (name, id) since yahoo only returns an integer id and value for player stats"

task import_nfl_stat_categories: :environment do
  NFL_URL = "http://fantasysports.yahooapis.com/fantasy/v2/game/nfl/stat_categories"
  fill_table(process_categories(DataImport.new.get_data(NFL_URL)))
end


def process_categories(xml)
  xml.elements.to_a("fantasy_content/game/stat_categories/stats/stat").map do |stat|
    stat_hash(stat)
  end
end

def stat_hash(xml)
  {
    name: xml.elements["name"].text,
    stat_id: xml.elements["stat_id"].text.to_i
  }
end

def fill_table(stats)
  stats.each do |stat|
    StatCategory.create(stat)
  end
end
