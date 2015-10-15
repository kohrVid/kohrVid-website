class ChangeImageUrlFormatInClients < ActiveRecord::Migration
  def change
	  change_column :clients, :image_url, :string
  end
end
