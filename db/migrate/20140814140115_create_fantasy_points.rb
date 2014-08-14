class CreateFantasyPoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.belongs_to :nfl_player, index: true, null: false
      t.float :value, null: false
      t.integer :week, null: false, default: 1
      t.timestamps null: false
    end
  end
end
