class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.text :name
      t.text :description
      t.string :image
      t.text :repo_url
      t.text :app_url
      t.text :description
      t.string :languages
      t.boolean :draft, default: true
      t.timestamps
    end
  end
end
