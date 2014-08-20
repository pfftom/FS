class CreateCurrentDraftPick < ActiveRecord::Migration
  def change
    create_table :current_draft_picks do |t|
      t.belongs_to :league, index: true, null: false
      t.string :team, null: false, default: ""
      t.integer :pick_index, null: false, default: 0
      t.timestamps null: false
    end
  end
end
