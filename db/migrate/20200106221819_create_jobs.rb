class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company_name
      t.string :company_website
      t.datetime :start_date
      t.datetime :end_date
      t.text :description

      t.timestamps
    end
  end
end
