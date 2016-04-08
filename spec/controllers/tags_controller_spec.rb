require 'rails_helper'

RSpec.describe TagsController, type: :controller do
	let(:valid_tag) { FactoryGirl.create(:tag) }
	let(:admin) { FactoryGirl.create(:admin) }

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
		it "assigns requested tag to @tag" do
			get(:show, id: valid_tag.id)
			expect(assigns(:tag)).to eq(valid_tag)
		end

		it "returns http success" do
			get(:show, id: valid_tag.id)
			expect(response).to have_http_status(:success)
		end
	end
	
	describe "GET #new" do
		before(:each) do
			sign_in :user, admin
		end

		it "returns http success" do
			get(:new)
			expect(response).to have_http_status(:success)
		end
	end

	describe "POST create" do
		before(:each) do
			sign_in :user, admin
		end

		context "with valid attributes" do
			it "creates a new post" do
				expect{
					post :create, tag: FactoryGirl.attributes_for(:tag)
				}.to change(Tag, :count).by(1)
			end

			it "redirects to the new tag" do
				post :create, tag: FactoryGirl.attributes_for(:tag)
				expect(response).to redirect_to Tag.last
			end

			it "displays the correct flash message on redirect" do
				post :create, tag: FactoryGirl.attributes_for(:tag)
				expect(flash[:success]).to have_content("Tag was created successfully.")
			end
		end

		context "with invalid attributes" do
			it "doesn't save the new tag" do
				expect{
					post :create, tag: FactoryGirl.attributes_for(:tag, name: "")
				}.to_not change(Tag, :count)
			end

			it "re-renders the new method" do
				post :create, tag: FactoryGirl.attributes_for(:tag, name: "")
				expect(response).to render_template :new
			end

			it "displays the correct flash message on redirect" do
				post :create, tag: FactoryGirl.attributes_for(:tag, name: "")
				expect(flash[:error]).to have_content("An error has prevented this tag from being saved")
			end
		end
	end

	describe "GET #edit" do
		before(:each) do
			sign_in :user, admin
			@tag = valid_tag
		end

		it "assigns requested post to @tag" do
			get(:edit, id: valid_tag.id)
			expect(assigns(:tag)).to eq(valid_tag)
		end

		it "returns http success" do
			get(:edit, id: valid_tag.id)
			expect(response).to have_http_status(:success)
		end
	end

	describe "PUT update" do
		before(:each) do
			sign_in :user, admin
			@tag = valid_tag
		end

		context "with valid attributes" do
			it "locates the requested @tag" do
				put :update, id: @tag.id, tag: FactoryGirl.attributes_for(:tag)
				expect(assigns(:tag)).to eq(valid_tag)
			end

			it "changes @tag's attributes" do
				put :update, id: @tag.id, tag: FactoryGirl.attributes_for(:tag, name: "Food")
				valid_tag.reload
				expect(@tag.name).to eq("Food")
			end

			it "redirects to the updated post" do
				put :update, id: @tag.id, tag: FactoryGirl.attributes_for(:tag, name: "Food")
				expect(response).to redirect_to valid_tag
			end

			it "displays the correct flash message on redirect" do
				put :update, id: @tag.id, tag: FactoryGirl.attributes_for(:tag, name: "Food")
				expect(flash[:success]).to have_content("Tag updated.")
			end
		end

		context "with invalid attributes" do
			it "shouldn't change @tag's attributes" do
				put :update, id: @tag.id, tag: FactoryGirl.attributes_for(:tag, name: "")
				@tag.reload
				expect(@tag.name).to_not eq("")
			end

			it "renders the edit post" do
				put :update, id: @tag.id, tag: FactoryGirl.attributes_for(:tag, name: "")
				expect(response).to render_template :edit
			end

			it "displays the correct flash message on redirect" do
				put :update, id: @tag.id, tag: FactoryGirl.attributes_for(:tag, name: "")
				expect(flash[:error]).to have_content("Unable to update tag.")
			end
		end
	end

	describe "DELETE destroy" do
		before(:each) do
			sign_in :user, admin
			@tag = valid_tag
		end

		it "deletes the post" do
			expect{
				delete :destroy, id: @tag.id
			}.to change(Tag, :count).by(-1)
		end

		it "redirects to the tags#index" do
			delete :destroy, id: @tag.id
			expect(response).to redirect_to tags_path
		end

		it "displays the correct flash message on redirect" do
			delete :destroy, id: @tag.id
			expect(flash[:success]).to have_content("Tag deleted.")
		end
	end
	
end
