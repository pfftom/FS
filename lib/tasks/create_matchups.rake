desc "Create matchups for each league for the week - ideally run this every week"
task create_matchups: :environment do
  League.all.each do |league|
    MatchCreate.new(league).new_matchups
  end
end
