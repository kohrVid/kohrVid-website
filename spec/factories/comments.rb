FactoryBot.define do
  factory :comment do
    author { (User.last || create(:user, :reader)).name }
    body { "MyText" }
    post { Post.last || create(:post) }
    user { User.last || create(:user, :reader) }
  end
end
