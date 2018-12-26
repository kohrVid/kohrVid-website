class ChangeLogoUrlFormatInClients < ActiveRecord::Migration[4.2]
  def change
	  change_column :clients, :logo_url, :string
  end
end
