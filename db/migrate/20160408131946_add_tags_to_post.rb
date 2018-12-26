class AddTagsToPost < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :tag_list, :string
  end
end
