FactoryBot.define do
  factory :job do
   title { "Witch Doctor" }
   company_name { "The Wood Wide Web" }
   company_website { "https://www.kohrvid.com/wood-wide" }
   start_date { DateTime.new(2020, 01, 06, 00, 07) }
   end_date { DateTime.new(2020, 01, 16, 00, 07) }
   description { Faker::Lorem.paragraph }
  end
end
