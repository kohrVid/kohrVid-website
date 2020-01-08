FactoryBot.define do
  factory :job do
    html_content = "<div>#{Faker::Lorem.sentence}</div>"
    content = ActionText::Content.new(html_content)
    rich_text_description = ActionText::RichText.new(body: content)

    title { "Witch Doctor" }
    company_name { "The Wood Wide Web" }
    company_website { "https://www.kohrvid.com/wood-wide" }
    start_date { DateTime.new(2020, 01, 06, 00, 07) }
    end_date { DateTime.new(2020, 01, 16, 00, 07) }
    description { rich_text_description }
  end
end
