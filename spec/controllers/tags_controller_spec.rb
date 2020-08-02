require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:valid_tag) { FactoryBot.create(:tag) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user) { FactoryBot.create(:user, :reader_one) }

  describe "GET #index" do
    it "populates an array of tags" do
      get :index
      expect(assigns(:tags)).to eq([valid_tag])
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    before do
      get(:show, params: { id: valid_tag.id })
    end

    it "assigns requested tag to @tag" do
      expect(assigns(:tag)).to eq(valid_tag)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    subject { get(:new) }

    context "as a signed-out user" do
      it "redirects to the new tag" do
        expect { subject }.to raise_error
      end
    end

    context "as a non-admin user" do
      before(:each) do
        sign_in user, scope: :user
      end

      it "redirects to the new tag" do
        expect { subject }.to raise_error
      end
    end

    context "as an admin" do
      before(:each) do
        sign_in admin, scope: :user
        subject
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST create" do
    subject(:post_attributes) do
      post :create, params: {
        tag: FactoryBot.attributes_for(:tag)
      }
    end

    context "as a signed-out user" do
      it "redirects to the new tag" do
        expect { post_attributes }.to raise_error
      end
    end

    context "as a non-admin user" do
      before(:each) do
        sign_in user, scope: :user
      end

      it "redirects to the new tag" do
        expect { post_attributes }.to raise_error
      end
    end

    context "as an admin" do
      before(:each) do
        sign_in admin, scope: :user
      end

      context "with valid attributes" do
        subject(:post_attributes) do
          post :create, params: {
            tag: FactoryBot.attributes_for(:tag)
          }
        end

        it "creates a new post" do
          expect { post_attributes }.to change(Tag, :count).by(1)
        end

        it "redirects to the new tag" do
          is_expected.to redirect_to Tag.last
        end

        it "displays the correct flash message on redirect" do
          subject

          expect(flash[:success]).to have_content(
            "Tag was created successfully."
          )
        end
      end

      context "with invalid attributes" do
        subject(:post_attributes) do
          post :create, params: {
            tag: FactoryBot.attributes_for(:tag, name: '')
          }
        end

        it "doesn't save the new tag" do
          expect{ post_attributes }.to_not change(Tag, :count)
        end

        it "re-renders the new method" do
          is_expected.to render_template :new
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:error])
            .to have_content("An error has prevented this tag from being saved")
        end
      end
    end
  end

  describe "GET #edit" do
    subject do
      get(:edit, params: { id: valid_tag.id })
    end

    context "as a signed-out user" do
      it "redirects to the new tag" do
        expect { subject }.to raise_error
      end
    end

    context "as a non-admin user" do
      before(:each) do
        sign_in user, scope: :user
      end

      it "redirects to the new tag" do
        expect { subject }.to raise_error
      end
    end

    context "as an admin" do
      before(:each) do
        sign_in admin, scope: :user
        subject
      end

      it "assigns requested post to @tag" do
        expect(assigns(:tag)).to eq(valid_tag)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PUT update" do
    subject(:put_attributes) do
      put :update, params: {
        id: valid_tag.id, tag: FactoryBot.attributes_for(:tag, name: 'Food')
      }
    end

    context "as a signed-out user" do
      it "redirects to the new tag" do
        expect { put_attributes }.to raise_error
      end
    end

    context "as a non-admin user" do
      before(:each) do
        sign_in user, scope: :user
      end

      it "redirects to the new tag" do
        expect { put_attributes }.to raise_error
      end
    end

    context "as an admin" do
      before(:each) do
        sign_in admin, scope: :user
      end

      context "with valid attributes" do
        it "changes @tag's attributes" do
          expect { put_attributes }
            .to change { Tag.find(valid_tag.id).name }
            .from(valid_tag.name).to('Food')
        end

        it "redirects to the updated post" do
          is_expected.to redirect_to valid_tag
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:success]).to have_content("Tag updated.")
        end
      end

      context "with invalid attributes" do
        subject(:put_attributes) do
          put :update, params: {
            id: valid_tag.id, tag: FactoryBot.attributes_for(:tag, name: '')
          }
        end

        it "shouldn't change @tag's attributes" do
          valid_tag.reload
          expect { put_attributes }
            .to_not change { Tag.find(valid_tag.id).name }
        end

        it "renders the edit post" do
          is_expected.to render_template :edit
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:error]).to have_content("Unable to update tag.")
        end
      end
    end
  end

  describe "DELETE destroy" do
    subject(:delete_tag) do
      delete :destroy, params: { id: valid_tag.id }
    end

    context "as a signed-out user" do
      it "redirects to the new tag" do
        expect { delete_tag }.to raise_error
      end
    end

    context "as a non-admin user" do
      before(:each) do
        sign_in user, scope: :user
      end

      it "redirects to the new tag" do
        expect { delete_tag }.to raise_error
      end
    end

    context "as an admin" do
      before(:each) do
        sign_in admin, scope: :user
        valid_tag
      end

      it "deletes the post" do
        expect { delete_tag }.to change(Tag, :count).by(-1)
      end

      it "redirects to the tags#index" do
        is_expected.to redirect_to tags_path
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:success]).to have_content("Tag deleted.")
      end
    end
  end
end
