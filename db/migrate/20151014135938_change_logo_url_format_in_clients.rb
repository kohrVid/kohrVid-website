class ChangeLogoUrlFormatInClients < ActiveRecord::Migration
  def change
	  change_column :clients, :logo_url, :string
  end
end
