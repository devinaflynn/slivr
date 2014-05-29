class RemoveVisitableIdAndVisitableTypeFromVisit < ActiveRecord::Migration
  def up
    remove_index :visits, :visitable_id
    remove_index :visits, :visitable_type
    remove_column :visits, :visitable_id
    remove_column :visits, :visitable_type
  end

  def down
    add_column :visits, :visitable_type, :string
    add_column :visits, :visitable_id, :integer
    add_index :visits, :visitable_id
    add_index :visits, :visitable_type
  end
end