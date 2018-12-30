FactoryBot.define do
  factory :comment do
    author "MyString"
    body "MyText"
    post
    user_id { create(:user, :reader).id }
  end
end
