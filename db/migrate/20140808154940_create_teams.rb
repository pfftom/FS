class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.belongs_to :user, index: true, null: false
      t.belongs_to :league, index: true, null: false
      t.timestamps null: false
    end
  end
end
