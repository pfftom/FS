class AddAdminToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :drafted, :boolean, default: false
    add_column :leagues, :admin_id, :integer
    add_index :leagues, :admin_id
  end
end
