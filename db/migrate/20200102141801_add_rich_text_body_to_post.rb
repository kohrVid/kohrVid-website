class AddRichTextBodyToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :rich_text_body, :text
  end
end
