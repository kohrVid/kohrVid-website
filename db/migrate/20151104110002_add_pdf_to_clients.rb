class AddPdfToClients < ActiveRecord::Migration
  def change
	  add_column :clients, :pdf, :string
  end
end
