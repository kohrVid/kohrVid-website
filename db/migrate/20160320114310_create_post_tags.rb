class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags, id: false do |t|
		 t.integer :post_id
		 t.integer :tag_id

      t.timestamps null: false
    end
  end
end
