class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.belongs_to :team, index: true, null: false
      t.belongs_to :player, index: true, null: false
    end
  end
end
