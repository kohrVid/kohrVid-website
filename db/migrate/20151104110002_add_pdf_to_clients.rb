class AddPdfToClients < ActiveRecord::Migration[4.2]
  def change
	  add_column :clients, :pdf, :string
  end
end
