class AddRankingToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :rank, :integer
  end
end
