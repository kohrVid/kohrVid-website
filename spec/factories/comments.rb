FactoryBot.define do
  factory :comment do
    author { "MyString" }
    body { "MyText" }

    post do
      Post.where(title: attributes_for(:post)[:title])
        .first_or_create(attributes_for(:post))
    end

    user_id do
      create(:user, :reader).id
    end
  end
end
