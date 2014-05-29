class AddPinIdToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :pin_id, :integer
    add_index :visits, :pin_id
  end
end