class CreateNflStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :value, null: false
      t.integer :stat_id, null: false
      t.string :name, null: false
      t.belongs_to :nfl_player, index: true, null: false
    end
  end
end
