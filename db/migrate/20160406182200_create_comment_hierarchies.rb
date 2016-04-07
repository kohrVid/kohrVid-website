class CreateCommentHierarchies < ActiveRecord::Migration
  def change
    create_table :comment_hierarchies, id: false do |t|
		 t.integer :ancestor_id, null: false
		 t.integer :descendant_id, null: false
		 t.integer :generations, null: false
    end
	 add_index :comment_hierarchies, [:descendant_id],
		 			name: "comment_desc_idx"
  end
end
