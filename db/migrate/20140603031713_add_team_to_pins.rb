class AddTeamToPins < ActiveRecord::Migration
  def change
    add_column :pins, :team, :string
    add_column :pins, :position, :string

  end
end
