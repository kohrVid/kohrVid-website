class RenameClientImageUrl < ActiveRecord::Migration[5.2]
  def change
    rename_column :clients, :image_url, :image
    rename_column :clients, :client_name, :name
    rename_column :clients, :logo_url, :logo
  end
end
