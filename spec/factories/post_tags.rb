FactoryGirl.define do
	factory :post_tag do
		post_id { create(:post).id }
		tag_id { create(:tag).id }
	end
end
