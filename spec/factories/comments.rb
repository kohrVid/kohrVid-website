FactoryGirl.define do
  factory :comment do
    author "MyString"
    body "MyText"
	 post_id { create(:post).id }
	 user_id { create(:user).id }
  end
end
