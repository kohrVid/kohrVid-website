FactoryBot.define do
  factory :post_tag do
    post { Post.find_or_create_by(attributes_for(:post)) }
    tag { Tag.find_or_create_by(attributes_for(:tag)) }
  end
end
