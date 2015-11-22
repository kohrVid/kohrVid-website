require 'rails_helper'

RSpec.describe Contact < MailForm::Base, type: :model do
	before do
		@valid_attributes = {
			name: "Abby",
			email: "abby@telesur.ve",
			message: "Each November, Americans celebrate a mythical version of U.S. history. Thanksgiving Day's portrayal of the experience of Native Americans under the boot of settler-colonialism is one of the Empire's most cherished falsehoods.",
			nickname: ""

		}
	end

	it "creates a new contact with valid attributes" do
		expect(lambda{
			Contact.create(@valid_attributes)
		}).to change(Contact, :count).by(1)
	end

	it "" do
	end

	context "Name" do
	end

	context "Email" do
	end

	context "Message" do
	end

	context "Nickname" do
	end

end
