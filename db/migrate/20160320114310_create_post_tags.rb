class CreatePostTags < ActiveRecord::Migration[4.2]
  def change
    create_table :post_tags do |t|
		 t.belongs_to :post, index: true, foreign_key: true
		 t.belongs_to :tag, index: true,foreign_key: true

      t.timestamps null: false
    end
  end
end
