FactoryBot.define do
  factory :comment do
    author { "MyString" }
    body { "MyText" }
    post { Post.find_or_create_by(attributes_for(:post)) }

    user_id {
      create(:user, :reader).id
    }
  end
end
