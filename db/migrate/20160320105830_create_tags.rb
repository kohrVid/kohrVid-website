class CreateTags < ActiveRecord::Migration[4.2]
  def change
    create_table :tags do |t|
		 t.text :name

      t.timestamps null: false
    end
  end
end
