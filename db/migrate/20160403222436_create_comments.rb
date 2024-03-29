class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.string :author
      t.text :body
		t.references :user, index: true, foreign_key: true
		t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
