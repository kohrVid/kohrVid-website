FactoryBot.define do
  factory :post_tag do
    post do
      p = Post.where(
        attributes_for(:post).select { |k,_| k != :rich_text_body }
      )
      if p.any?
        p.first
      else
        create(:post)
      end
    end

    tag { Tag.find_or_create_by(attributes_for(:tag)) }
  end
end
