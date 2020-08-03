require 'rails_helper'

RSpec.describe NestController, type: :controller do
  let(:valid_job) { FactoryBot.create(:job) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user) { FactoryBot.create(:user, :reader_one) }

  describe "GET #about" do
    let(:get_about) { get :about, params: { id: valid_job.id } }

    context "Admin user" do
      before do
        valid_job
        sign_in admin, scope: :user
      end

      it "returns http success" do
        expect(get_about).to have_http_status(:success)
      end

      xit "populates a job" do
        expect(assigns(:jobs)).to eq([valid_job])
      end
    end

    context "Standard User" do
      before do
        valid_job
        sign_in user, scope: :user
      end

      it "returns http success" do
        expect(get_about).to have_http_status(:success)
      end
    end

    context "Anonymous User" do
      it "returns http success" do
        expect(get_about).to have_http_status(:success)
      end
    end
  end
end
