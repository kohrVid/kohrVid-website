FactoryBot.define do
  factory :comment do
    author { "MyString" }
    body { "<p>MyText</p>" }

    post do
      Post.where(title: attributes_for(:post)[:title])
        .first_or_create(attributes_for(:post))
    end

    user_id do
      User.where(name: attributes_for(:user, :reader_one)[:name])
        .first_or_create(attributes_for(:user, :reader_one)).id
    end
  end
end
