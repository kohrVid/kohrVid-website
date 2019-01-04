require 'rails_helper'

RSpec.describe Client, type: :model do
  it "must have required fields or be invalid" do
    c = Client.new
    expect(c).to_not be_valid
  end

  it "creates a new client with valid attributes" do
    expect{
      Client.create(FactoryBot.attributes_for(:client))
    }.to change(Client, :count).by(1)
  end

  context "Name" do
    it "must be present" do
      expect{
        Client.create(FactoryBot.attributes_for(:client, client_name: ""))
      }.to_not change(Client, :count)
    end

    it "must produce an error if no name is given" do
      c = Client.new
      expect(c.errors[:client_name]).to_not be_nil
    end
  end

  context "URL" do
    it "must be present" do
      expect{
        Client.create(FactoryBot.attributes_for(:client, client_url: ""))
      }.to_not change(Client, :count)
    end

    it "must produce an error if no URL is given" do
      c = Client.new
      expect(c.errors[:client_url]).to_not be_nil
    end
  end

end
