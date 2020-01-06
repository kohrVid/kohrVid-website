require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:valid_post) { FactoryBot.create(:post) }

  let(:draft_post) do
    Post.create(
      FactoryBot.attributes_for(
        :post,
        title: "Rough",
        body: "copy",
        draft: true,
        published_at: nil)
    )
  end

  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user) { FactoryBot.create(:user, :reader) }

  describe "GET #index" do
    before do
      get :index
    end

    it "populates an array of posts" do
      expect(assigns(:posts)).to eq([valid_post])
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    context "Final Draft" do
      before do
        get(:show, params: { id: valid_post.id })
      end

      it "assigns requested post to valid_post" do
        expect(assigns(:post)).to eq(valid_post)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "Rough Draft" do
      let(:get_post) { get(:show, params: { id: draft_post.id }) }

      context "Admin user" do
        before do
          sign_in admin, scope: :user
          get_post
        end

        it "assigns requested post to valid_post" do
          expect(assigns(:post)).to eq(draft_post)
        end

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
      end

      context "Standard User" do
        it "returns http success" do
          sign_in user, scope: :user
          expect { get_post }.to raise_error(ActionController::RoutingError)
        end
      end

      context "Anonymous User" do
        it "returns http success" do
          expect { get_post }.to raise_error(ActionController::RoutingError)
        end
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
        post :create, params: { post: FactoryBot.attributes_for(:post) }
      end

      it "creates a new post" do
        expect { post_attributes }.to change(Post, :count).by(1)
      end

      it "redirects to the new post" do
        is_expected.to redirect_to Post.last
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:success]).to have_content("Post was created successfully.")
      end
    end

    context "with invalid attributes" do
      subject(:post_attributes) do
        post :create, params: {
          post: FactoryBot.attributes_for(:post, title: "")
        }
      end

      it "doesn't save the new post" do
        expect { post_attributes }.to_not change(Post, :count)
      end

      it "re-renders the new method" do
        is_expected.to render_template :new
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:error]).to have_content(
          "An error has prevented this post from being saved"
        )
      end
    end
  end

  describe "GET #edit" do
    before(:each) do
      sign_in admin, scope: :user
      get(:edit, params: { id: valid_post.id })
    end

    it "assigns requested post to valid_post" do
      expect(assigns(:post)).to eq(valid_post)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT update" do
    before(:each) do
      sign_in admin, scope: :user
    end

    context "with valid attributes" do
      subject(:put_attributes) do
        put :update, params: {
          id: valid_post.id, post: FactoryBot.attributes_for(
            :post, title: "Services", body: "These are the services we provide."
          )
        }
      end

      it "locates the requested valid_post" do
        subject
        expect(assigns(:post)).to eq(valid_post)
      end

      it "changes valid_post's title" do
        expect { put_attributes }
          .to change { Post.find(valid_post.id).title }
          .from(valid_post.title).to('Services')
      end

      it "changes valid_post's body" do
        expect { put_attributes }
          .to change { Post.find(valid_post.id).body }
          .from(valid_post.body).to('These are the services we provide.')
      end

      it "redirects to the updated post" do
        is_expected.to redirect_to valid_post
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:success]).to have_content("Post updated.")
      end
    end

    context "with invalid attributes" do
      subject(:put_attributes) do
        put :update, params: {
          id: valid_post.id, post: FactoryBot.attributes_for(
            :post, title: "", body: "r"
          )
        }
      end

      it "shouldn't change valid_post's title" do
        expect { put_attributes }
          .to_not change { Post.find(valid_post.id).title }
      end

      it "shouldn't change valid_post's body" do
        expect { put_attributes }
          .to_not change { Post.find(valid_post.id).body }
      end

      it "renders the edit post" do
        is_expected.to render_template :edit
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:error]).to have_content("Unable to update post.")
      end
    end
  end

  describe "DELETE destroy" do
    subject(:delete_post) do
      delete :destroy, params: { id: valid_post.id }
    end

    before do
      sign_in admin, scope: :user
      valid_post
    end

    it "deletes the post" do
      expect { delete_post }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts#index" do
      is_expected.to redirect_to posts_path
    end

    it "displays the correct flash message on redirect" do
      subject
      expect(flash[:success]).to have_content("Post deleted.")
    end
  end
end
