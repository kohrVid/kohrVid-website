namespace :blog do
  task :markdown_to_actiontext => :environment do
    include PostsHelper

    puts "Converting markdown text to ActionText..."

    Post.all.each do |post|
      updated_at = post.updated_at
      markdown_post = PostsHelper.markdown(
        post.body
      ).gsub("&ast;", "*")
      
      content = ActionText::Content.new(markdown_post)
      post.update(rich_text_body: content, updated_at: updated_at)
      puts "Converted #{post.inspect}"
    end

    puts "Done!"
  end
end
