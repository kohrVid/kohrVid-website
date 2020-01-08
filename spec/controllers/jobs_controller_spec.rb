require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  let(:valid_job) { FactoryBot.create(:job) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user) { FactoryBot.create(:user, :reader) }

  describe "GET #index" do
    let(:get_index) { get :index }

    context "Admin user" do
      before do
        valid_job
        sign_in admin, scope: :user
      end

      it "returns http success" do
        expect(get_index).to have_http_status(:success)
      end

      xit "populates an array of jobs" do
        expect(assigns(:jobs)).to eq([valid_job])
      end
    end

    context "Standard User" do
      before do
        valid_job
        sign_in user, scope: :user
      end

      it "should return a routing error" do
        expect { get_index }.to raise_error(ActionController::RoutingError)
      end
    end

    context "Anonymous User" do
      it "should return a routing error" do
        valid_job
        expect { get_index }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "GET #new" do
    let(:get_new) { get :new }

    context "Admin user" do
      before do
        valid_job
        sign_in admin, scope: :user
      end

      it "returns http success" do
        expect(get_new).to have_http_status(:success)
      end

      xit "populates job" do
        expect(assigns(:job)).to eq(Job.new)
      end
    end

    context "Standard User" do
      before do
        sign_in user, scope: :user
      end

      it "should return a routing error" do
        expect { get_new }.to raise_error(ActionController::RoutingError)
      end
    end

    context "Anonymous User" do
      it "should return a routing error" do
        expect { get_new }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "GET #show" do
    let(:get_show) { get :show, params: { id: valid_job.id } }

    context "Admin user" do
      before do
        valid_job
        sign_in admin, scope: :user
      end

      it "returns http success" do
        expect(get_show).to have_http_status(:success)
      end

      xit "populates a job" do
        expect(assigns(:job)).to eq(valid_job)
      end
    end

    context "Standard User" do
      before do
        valid_job
        sign_in user, scope: :user
      end

      it "should return a routing error" do
        expect { get_show }.to raise_error(ActionController::RoutingError)
      end
    end

    context "Anonymous User" do
      it "should return a routing error" do
        valid_job
        expect { get_show }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "GET #edit" do
    let(:get_edit) { get :edit, params: { id: valid_job.id } }

    context "Admin user" do
      before do
        valid_job
        sign_in admin, scope: :user
      end

      it "returns http success" do
        expect(get_edit).to have_http_status(:success)
      end

      xit "populates a job" do
        expect(assigns(:job)).to eq(valid_job)
      end
    end

    context "Standard User" do
      before do
        valid_job
        sign_in user, scope: :user
      end

      it "should return a routing error" do
        expect { get_edit }.to raise_error(ActionController::RoutingError)
      end
    end

    context "Anonymous User" do
      it "should return a routing error" do
        valid_job
        expect { get_edit }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "POST #create" do
    context "Admin user" do
      before(:each) do
        sign_in admin, scope: :user
      end

      context "with valid attributes" do
        subject(:job_attributes) do
          post :create, params: { job: FactoryBot.attributes_for(:job) }
        end

        xit "creates a new job" do
          expect { job_attributes }.to change(Job, :count).by(1)
        end

        xit "redirects to the new job" do
          is_expected.to redirect_to Job.last
        end

        xit "displays the correct flash message on redirect" do
          subject
          expect(flash[:success]).to have_content("Job was created successfully.")
        end
      end

      context "with invalid attributes" do
        subject(:job_attributes) do
          post :create, params: {
            job: FactoryBot.attributes_for(:job, title: "")
          }
        end

        it "doesn't save the new job" do
          expect { job_attributes }.to_not change(Job, :count)
        end

        it "re-renders the new method" do
          is_expected.to render_template :new
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:error]).to have_content(
            "An error has prevented this job from being saved"
          )
        end
      end
    end

    context "Standard User" do
      before do
        sign_in user, scope: :user
      end

      it "should return a routing error" do
        expect {
          post :create, params: { job: FactoryBot.attributes_for(:job) }
        }.to raise_error(ActionController::RoutingError)
      end
    end

    context "Anonymous User" do
      it "should return a routing error" do
        expect {
          post :create, params: { job: FactoryBot.attributes_for(:job) }
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      valid_job
      sign_in admin, scope: :user
    end

    context "with valid attributes" do
      let(:html_content) { "<div>These are the services we provide.</div>" }
      let(:content) { ActionText::Content.new(html_content) }
      let(:rich_text_description) { ActionText::RichText.new(body: content) }

      subject(:put_attributes) do
        put :update, params: {
          id: valid_job.id,
          job: FactoryBot.attributes_for(
            :job, title: "Services",
            description: rich_text_description
          )
        }
      end

      it "locates the requested valid_job" do
        subject
        expect(assigns(:job)).to eq(valid_job)
      end

      xit "changes valid_job's title" do
        expect { put_attributes }
          .to change { Job.find(valid_job.id).title }
          .from(valid_job.title).to('Services')
      end

      xit "changes valid_job's description" do
        expect { put_attributes }
          .to change { Job.find(valid_job.id).description }
          .from(valid_job.description.body.to_html)
          .to('<div>These are the services we provide.</div>')
      end

      xit "redirects to the updated job" do
        is_expected.to redirect_to valid_job
      end

      xit "displays the correct flash message on redirect" do
        subject
        expect(flash[:success]).to have_content("Job updated.")
      end
    end

    context "with invalid attributes" do
      subject(:put_attributes) do
        put :update, params: {
          id: valid_job.id, job: FactoryBot.attributes_for(
            :job, title: "", description: "r"
          )
        }
      end

      it "shouldn't change valid_job's title" do
        expect { put_attributes }
          .to_not change { Job.find(valid_job.id).title }
      end

      it "shouldn't change valid_job's description" do
        expect { put_attributes }
          .to_not change { Job.find(valid_job.id).description }
      end

      it "renders the edit job" do
        is_expected.to render_template :edit
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:error]).to have_content("Unable to update job.")
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:delete_job) do
      delete :destroy, params: { id: valid_job.id }
    end

    before do
      sign_in admin, scope: :user
      valid_job
    end

    it "deletes the job" do
      expect { delete_job }.to change(Job, :count).by(-1)
    end

    it "redirects to the jobs#index" do
      is_expected.to redirect_to jobs_path
    end

    it "displays the correct flash message on redirect" do
      subject
      expect(flash[:success]).to have_content("Job deleted.")
    end
  end
end
