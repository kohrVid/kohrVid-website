FactoryGirl.define do
	factory :post do
		title "This is my first blog post"
		body "I'm really excited to be writing my first post. Enjoy!"
		draft false
		published_at Time.new(2016, 03, 21, 11, 05, 00)
	end
end
