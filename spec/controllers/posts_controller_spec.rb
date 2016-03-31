require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	let(:valid_post) { FactoryGirl.create(:post) }
	let(:draft_post) { Post.create(title: "Rough", body: "copy", draft: true, published_at: nil) }
	let(:admin) { FactoryGirl.create(:user, name: "Princess", email: "princess@premiergaou.ci", admin: true) }
	let(:user) { FactoryGirl.create(:user) }

	describe "GET #index" do
		it "populates an array of posts" do
			get :index
			expect(assigns(:posts)).to eq([valid_post])
		end

		it "returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "GET #show" do
		context "Final Draft" do
			it "assigns requested post to @post" do
				get(:show, id: valid_post.id)
				expect(assigns(:post)).to eq(valid_post)
			end

			it "returns http success" do
				get(:show, id: valid_post.id)
				expect(response).to have_http_status(:success)
			end
		end
		
		context "Rough Draft" do
			context "Admin user" do
				before(:each) do
					sign_in admin
				end
				
				it "assigns requested post to @post" do
					get(:show, id: draft_post.id)
					expect(assigns(:post)).to eq(draft_post)
				end

				it "returns http success" do
					get(:show, id: draft_post.id)
					expect(response).to have_http_status(:success)
				end
			end
			
			context "Standard User" do
				it "returns http success" do
					sign_in user
					expect{
						get(:show, id: draft_post.id)
					}.to raise_error(ActionController::RoutingError)
				end
			end

			context "Anonymous User" do
				it "returns http success" do
					expect{
						get(:show, id: draft_post.id)
					}.to raise_error(ActionController::RoutingError)
				end
			end
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
					post :create, post: FactoryGirl.attributes_for(:post)
				}.to change(Post, :count).by(1)
			end

			it "redirects to the new post" do
				post :create, post: FactoryGirl.attributes_for(:post)
				expect(response).to redirect_to Post.last
			end

			it "displays the correct flash message on redirect" do
				post :create, post: FactoryGirl.attributes_for(:post)
				expect(flash[:success]).to have_content("Post was created successfully.")
			end
		end

		context "with invalid attributes" do
			it "doesn't save the new post" do
				expect{
					post :create, post: FactoryGirl.attributes_for(:post, title: "")
				}.to_not change(Post, :count)
			end

			it "re-renders the new method" do
				post :create, post: FactoryGirl.attributes_for(:post, title: "")
				expect(response).to render_template :new
			end

			it "displays the correct flash message on redirect" do
				post :create, post: FactoryGirl.attributes_for(:post, title: "")
				expect(flash[:error]).to have_content("An error has prevented this post from being saved")
			end
		end
	end

	describe "GET #edit" do
		before(:each) do
			sign_in :user, admin
			@post = valid_post
		end

		it "assigns requested post to @post" do
			get(:edit, id: valid_post.id)
			expect(assigns(:post)).to eq(valid_post)
		end

		it "returns http success" do
			get(:edit, id: valid_post.id)
			expect(response).to have_http_status(:success)
		end
	end

	describe "PUT update" do
		before(:each) do
			sign_in :user, admin
			@post = valid_post
		end

		context "with valid attributes" do
			it "locates the requested @post" do
				put :update, id: @post.id, post: FactoryGirl.attributes_for(:post)
				expect(assigns(:post)).to eq(valid_post)
			end

			it "changes @post's attributes" do
				put :update, id: @post.id, post: FactoryGirl.attributes_for(:post, title: "Services", body: "These are the services we provide.")
				valid_post.reload
				expect(@post.title).to eq("Services")
				expect(@post.body).to eq("These are the services we provide.")
			end

			it "redirects to the updated post" do
				put :update, id: @post.id, post: FactoryGirl.attributes_for(:post)
				expect(response).to redirect_to valid_post
			end

			it "displays the correct flash message on redirect" do
				put :update, id: @post.id, post: FactoryGirl.attributes_for(:post)
				expect(flash[:success]).to have_content("Post updated.")
			end
		end

		context "with invalid attributes" do
			it "shouldn't change @post's attributes" do
				put :update, id: @post.id, post: FactoryGirl.attributes_for(:post, title: "", body: "r")
				@post.reload
				expect(@post.title).to_not eq("")
				expect(@post.body).to_not eq("r")
			end

			it "renders the edit post" do
				put :update, id: @post.id, post: FactoryGirl.attributes_for(:post, title: "", body: "Raine is from Cote d'Ivoire")
				expect(response).to render_template :edit
			end

			it "displays the correct flash message on redirect" do
				put :update, id: @post.id, post: FactoryGirl.attributes_for(:post, title: "", body: "r")
				expect(flash[:error]).to have_content("Unable to update post.")
			end
		end
	end

	describe "DELETE destroy" do
		before(:each) do
			sign_in :user, admin
			@post = valid_post
		end

		it "deletes the post" do
			expect{
				delete :destroy, id: @post.id
			}.to change(Post, :count).by(-1)
		end

		it "redirects to the posts#index" do
			delete :destroy, id: @post.id
			expect(response).to redirect_to posts_path
		end

		it "displays the correct flash message on redirect" do
			delete :destroy, id: @post.id
			expect(flash[:success]).to have_content("Post deleted.")
		end
	end

end
