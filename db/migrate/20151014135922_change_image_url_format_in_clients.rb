class ChangeImageUrlFormatInClients < ActiveRecord::Migration[4.2]
  def change
	  change_column :clients, :image_url, :string
  end
end
