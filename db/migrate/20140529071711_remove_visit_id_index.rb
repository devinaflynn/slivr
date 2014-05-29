class RemoveVisitIdIndex < ActiveRecord::Migration
  def up
    remove_index :visit_details, :visit_id

  end

  def down
    add_index :visit_details, :visitable_id

  end
end