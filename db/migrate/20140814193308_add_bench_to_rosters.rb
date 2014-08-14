class AddBenchToRosters < ActiveRecord::Migration
  def change
    add_column :rosters, :active, :boolean, null: false, default: false
  end
end
