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

  describe 'scopes' do
    let(:client1) { FactoryBot.create(:client, draft: true) }
    let(:client2) { FactoryBot.create(:client, draft: false, rank: 2) }
    let(:client3) { FactoryBot.create(:client, draft: true) }
    let(:client4) { FactoryBot.create(:client, draft: false, rank: 1) }

    before do
      client1
      client2
      client3
      client4
    end

    context ".draft" do
      subject { Client.drafts }

      it 'should contain all draft clients' do
        is_expected.to include(client1)
        is_expected.to include(client3)
      end

      it 'should not contain any public clients' do
        is_expected.to_not include(client2)
        is_expected.to_not include(client4)
      end
    end

    context ".published" do
      subject { Client.published }

      it 'should contain all published clients' do
        is_expected.to include(client2)
        is_expected.to include(client4)
      end

      it 'should not contain any draft clients' do
        is_expected.to_not include(client1)
        is_expected.to_not include(client3)
      end

      it 'should be in order of ranking' do
        is_expected.to eq([client4, client2])
      end
    end
  end
end
