class AddDraftToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :draft, :boolean, draft: true
  end
end
