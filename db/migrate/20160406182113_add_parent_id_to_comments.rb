class AddParentIdToComments < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :parent_id, :integer
  end
end
