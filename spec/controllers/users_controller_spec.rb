require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	let(:user) { FactoryBot.create(:user) }
	let(:admin) { FactoryBot.create(:admin) }

	describe "GET #index" do
		before(:each) do
			sign_in :user, user
		#	allow(controller).to receive(:current_user).and_return(user)
		end

		it "populates an array of users" do
			get :index
			expect(assigns(:users)).to eq([user, admin])
		end

		it "returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "GET #show" do
		before(:each) do
			sign_in :user, user
			#allow(controller).to receive(:current_user).and_return(user)
		end
		
		it "assigns requested user to @user" do
			get(:show, id: user.id)
			expect(assigns(:user)).to eq(user)
		end

		it "returns http success" do
			get(:show, id: user.id)
			expect(response).to have_http_status(:success)
		end
	end

	describe "GET #new" do
		before(:each) do
			sign_in :user, admin
			#allow(controller).to receive(:current_user).and_return(admin)
		end

		it "returns http success" do
			get(:new)
			expect(response).to have_http_status(:success)
		end
	end

	describe "POST create" do
		before(:each) do
			sign_in :user, admin
			#allow(controller).to receive(:current_user).and_return(admin)
		end

		context "with valid attributes" do
			it "creates a new user" do
				expect{
					post :create, user: FactoryBot.attributes_for(:user)
				}.to change(User, :count).by(1)
			end

			it "redirects to the new user" do
				post :create, user: FactoryBot.attributes_for(:user)
				expect(response).to redirect_to User.last
			end

			it "displays the correct flash message on redirect" do
				post :create, user: FactoryBot.attributes_for(:user)
				expect(flash[:success]).to have_content("User was created successfully.")
			end
		end

		context "with invalid attributes" do
			it "doesn't save the new user" do
				expect{
					post :create, user: FactoryBot.attributes_for(:user, name: "")
				}.to_not change(User, :count)
			end

			it "re-renders the new method" do
				post :create, user: FactoryBot.attributes_for(:user, name: "")
				expect(response).to render_template :new
			end

			it "displays the correct flash message on redirect" do
				post :create, user: FactoryBot.attributes_for(:user, name: "")
				expect(flash[:error]).to have_content("An error has prevented this account from being saved")
			end
		end
	end

	describe "GET #edit" do
		before(:each) do
			sign_in :user, admin
			@user = user
		end

		it "assigns requested user to @user" do
			get(:edit, id: user.id)
			expect(assigns(:user)).to eq(user)
		end

		it "returns http success" do
			get(:edit, id: user.id)
			expect(response).to have_http_status(:success)
		end
	end

	describe "PUT update" do
		before(:each) do
			sign_in :user, admin
			@user = user
		end

		context "with valid attributes" do
			it "locates the requested @user" do
				put :update, id: @user.id, user: FactoryBot.attributes_for(:user)
				expect(assigns(:user)).to eq(user)
			end

			it "changes @user's attributes" do
				put :update, id: @user.id, user: FactoryBot.attributes_for(:user, name: "Services", bio: "These are the services we provide.")
				user.reload
				expect(@user.name).to eq("Services")
				expect(@user.bio).to eq("These are the services we provide.")
			end

			it "redirects to the updated user" do
				put :update, id: @user.id, user: FactoryBot.attributes_for(:user)
				expect(response).to redirect_to user
			end

			it "displays the correct flash message on redirect" do
				put :update, id: @user.id, user: FactoryBot.attributes_for(:user)
				expect(flash[:success]).to have_content("Profile updated.")
			end
		end

		context "with invalid attributes" do
			it "shouldn't change @user's attributes" do
				put :update, id: @user.id, user: FactoryBot.attributes_for(:user, name: "", bio: "r")
				@user.reload
				expect(@user.name).to_not eq("")
				expect(@user.bio).to_not eq("r")
			end

			it "renders the edit user" do
				put :update, id: @user.id, user: FactoryBot.attributes_for(:user, name: "", bio: "Raine is from Cote d'Ivoire")
				expect(response).to render_template :edit
			end

			it "displays the correct flash message on redirect" do
				put :update, id: @user.id, user: FactoryBot.attributes_for(:user, name: "", bio: "r")
				expect(flash[:error]).to have_content("Unable to update profile.")
			end
		end
	end

	describe "DELETE destroy" do
		before(:each) do
			sign_in :user, admin
			@user = user
		end

		it "deletes the user" do
			expect{
				delete :destroy, id: @user.id
			}.to change(User, :count).by(-1)
		end

		it "redirects to the users#index" do
			delete :destroy, id: @user.id
			expect(response).to redirect_to users_path
		end

		it "displays the correct flash message on redirect" do
			delete :destroy, id: @user.id
			expect(flash[:success]).to have_content("User deleted.")
		end
	end
end
