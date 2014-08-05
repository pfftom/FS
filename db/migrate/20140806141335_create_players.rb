class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :nfl_players do |t|
      t.string :yahoo_key, null: false
      t.string :yahoo_id, null: false
      t.string :name, null: false
      t.string :team, null: false
      t.string :position, null: false
      t.string :position_type, null: false
      t.integer :bye, null: false
      t.string :avatar_url, null: false

      t.timestamps null: false
    end
  end
end
