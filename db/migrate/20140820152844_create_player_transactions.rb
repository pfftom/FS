class CreatePlayerTransactions < ActiveRecord::Migration
  def change
    create_table :player_transactions do |t|
      t.belongs_to :league, index: true, null: false
      t.belongs_to :team, index: true, null: false
      t.string :player, null: false
      t.string :action, null: false
      t.timestamps null: false
    end
  end
end
