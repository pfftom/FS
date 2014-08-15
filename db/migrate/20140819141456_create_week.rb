class CreateWeek < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :value, null: false, default: 1
    end
  end
end
