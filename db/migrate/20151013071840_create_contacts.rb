class CreateContacts < ActiveRecord::Migration[4.2]
  def change
    create_table :contacts do |t|
	    t.string :name
	    t.string :email
	    t.text :message
	    t.string :nickname

      t.timestamps null: false
    end
  end
end
