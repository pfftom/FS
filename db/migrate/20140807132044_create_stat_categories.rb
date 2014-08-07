class CreateStatCategories < ActiveRecord::Migration
  def change
    create_table :stat_categories do |t|
      t.integer :stat_id, null: false
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
