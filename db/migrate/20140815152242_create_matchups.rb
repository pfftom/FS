class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.belongs_to :league, index: true, null: false
      t.integer :week, null: false
      t.belongs_to :home_team, index: true, null: false
      t.belongs_to :away_team, index: true, null: false
      t.integer :winning_team_id

      t.timestamps null: false
    end
  end
end
