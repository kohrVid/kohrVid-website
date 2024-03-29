require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user, :reader_one) }
  let(:admin) { FactoryBot.create(:user, :admin) }

  describe "GET #index" do
    before(:each) do
      sign_in admin, scope: :user
      get :index
    end

    it "populates an array of users" do
      expect(assigns(:users)).to include(user)
      expect(assigns(:users)).to include(admin)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    context "logged out user" do
      subject do
        get(:show, params: { id: user.id })
      end

      it "redirects to the new user" do
        is_expected.to redirect_to login_path
      end
    end

    context "logged in user" do
      before(:each) do
        sign_in admin, scope: :user
        get(:show, params: { id: user.id })
      end

      it "assigns requested user to @user" do
        expect(assigns(:user)).to eq(user)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #new" do
    before(:each) do
      sign_in admin, scope: :user
      get(:new)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    before(:each) do
      sign_in admin, scope: :user
    end

    context "with valid attributes" do
      subject(:post_attributes) do
        post :create, params: {
          user: FactoryBot.attributes_for(:user, :reader_one)
        }
      end

      it "creates a new user" do
        expect { post_attributes }.to change(User, :count).by(1)
      end

      it "redirects to the new user" do
        is_expected.to redirect_to User.last
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:success]).to have_content("User was created successfully.")
      end
    end

    context "with invalid attributes" do
      subject(:post_attributes) do
        post :create, params: {
          user: FactoryBot.attributes_for(:user, :reader_one, name: "")
        }
      end

      it "doesn't save the new user" do
        expect { post_attributes }.to_not change(User, :count)
      end

      it "re-renders the new method" do
        is_expected.to render_template :new
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:error]).to have_content(
          "An error has prevented this account from being saved"
        )
      end
    end
  end

  describe "GET #edit" do
    before do
      sign_in admin, scope: :user
      get(:edit, params: { id: user.id })
    end

    it "assigns requested user to @user" do
      expect(assigns(:user)).to eq(user)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT update" do
    before do
      sign_in admin, scope: :user
    end

    context "with valid attributes" do
      subject(:put_attributes) do
        put :update, params: {
          id: user.id,
          user: FactoryBot.attributes_for(
            :user,
            :reader_one,
            name: 'Raine',
            bio: 'Raine is from Cote d\'Ivoire'
          )
        }
      end

      it "changes @user's name" do
        expect { put_attributes }
          .to change { User.find(user.id).name }
          .from(user.name).to('Raine')
      end

      it "changes @user's bio" do
        expect { put_attributes }
          .to change { User.find(user.id).bio }
          .from(user.bio).to( 'Raine is from Cote d\'Ivoire')
      end

      it "redirects to the updated user" do
        is_expected.to redirect_to user
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:success]).to have_content("Profile updated.")
      end
    end

    context "with invalid attributes" do
      subject(:put_attributes) do
        put :update, params: {
          id: user.id,
          user: FactoryBot.attributes_for(
            :user,
            :reader_one,
            name: "",
            bio: "r"
          )
        }
      end

      it "does not change @user's name" do
        expect { put_attributes }
          .to_not change { User.find(user.id).name }
      end

      it "does not change @user's bio" do
        expect { put_attributes }
          .to_not change { User.find(user.id).bio }
      end

      it "renders the edit user" do
        is_expected.to render_template :edit
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:error]).to have_content("Unable to update profile.")
      end
    end
  end

  describe "DELETE destroy" do
    context 'as a signed out user' do
      subject(:delete_user) do
        delete :destroy, params: { id: user.id }
      end

      before(:each) do
        user
      end

      it "doesn't delete the user" do
        expect { delete_user }.to_not change(User, :count)
      end

      it "redirects to the login page" do
        is_expected.to redirect_to login_path
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:error]).to have_content("Please log in")
      end
    end

    context 'as a different user' do
      let(:user2) { FactoryBot.create(:user, :reader_two) }

      subject(:delete_user) do
        delete :destroy, params: { id: user.id }
      end

      before(:each) do
        user
        sign_in user2, scope: :user
      end

      it "doesn't delete the user" do
        expect { delete_user }.to_not change(User, :count)
      end

      it "renders the #show page" do
        is_expected.to render_template :show, :user
      end

      it "displays the correct flash message on redirect" do
        subject

        expect(flash[:error]).to have_content(
          "Sorry, you do not have access to that part of the site."
        )
      end
    end

    context 'as the correct user' do
      subject(:delete_user) do
        delete :destroy, params: { id: user.id }
      end

      before(:each) do
        sign_in user, scope: :user
        user
      end

      it "deletes the user" do
        expect { delete_user }.to change(User, :count).by(-1)
      end

      it "redirects to the users#index" do
        is_expected.to redirect_to users_path
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:success]).to have_content("User deleted.")
      end
    end

    context 'as an admin user' do
      subject(:delete_user) do
        delete :destroy, params: { id: user.id }
      end

      before(:each) do
        sign_in admin, scope: :user
        user
      end

      it "deletes the user" do
        expect { delete_user }.to change(User, :count).by(-1)
      end

      it "redirects to the users#index" do
        is_expected.to redirect_to users_path
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:success]).to have_content("User deleted.")
      end
    end
  end
end
