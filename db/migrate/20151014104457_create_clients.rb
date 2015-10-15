class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
	    t.text :client_name
	    t.text :client_url
	    t.text :image_url
	    t.text :logo_url
	    t.text :description
	    

      t.timestamps null: false
    end
  end
end
