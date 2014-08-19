class AddImpactToRosters < ActiveRecord::Migration
  def change
    add_column :rosters, :impact, :boolean, null: false, default: false
  end
end
