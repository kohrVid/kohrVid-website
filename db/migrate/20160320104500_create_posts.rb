class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
		 t.text :title
		 t.text :body
		 t.boolean :draft, default: true

      t.timestamps null: false
    end
  end
end
