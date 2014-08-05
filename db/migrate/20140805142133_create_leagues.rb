class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name, null: false
      t.string :sport, null: false

      t.timestamps null: false
    end
  end
end
