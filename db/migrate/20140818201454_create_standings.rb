class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.belongs_to :league, index: true, null: false
      t.belongs_to :team, index: true, null: false
      t.integer :wins, null: false, default: 0
      t.integer :losses, null: false, default: 0
      t.integer :ties, null: false, default: 0

      t.timestamps null: false
    end
  end
end
