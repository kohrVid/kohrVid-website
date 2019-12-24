require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:blog_post) { FactoryBot.create(:post) }
  let(:valid_comment) { FactoryBot.create(:comment, post: blog_post) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user) { FactoryBot.create(:user, :reader) }

  describe "GET #index" do
    before do
      sign_in admin, scope: :user
      get(:index, params: { id: valid_comment.id, post_id: blog_post.id })
    end

    it "assigns requested post to valid_comment" do
      expect(assigns(:comments)).to eq(valid_comment.hash_tree)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    before do
      allow(Notification)
        .to receive(:new_comment_admin_notification)
        .and_call_original
      
      blog_post
      sign_in admin, scope: :user
    end

    context "with valid attributes" do
      subject(:post_attributes) do
        post :create, params: {
          post_id: blog_post.id,
          comment: FactoryBot.attributes_for(:comment, post: blog_post)
        }
      end

      it "creates a new comment" do
        expect { post_attributes }.to change(Comment, :count).by(1)
      end

      it "redirects to the correct post" do
        is_expected.to redirect_to valid_comment.post
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:success]).to have_content(
          "Your comment was added successfully!"
        )
      end

      it "sends a notification to the admin" do
        subject
        expect(Notification)
          .to have_received(:new_comment_admin_notification).with(Comment.last)
      end
    end

    context "with invalid attributes" do
      subject(:post_attributes) do
        post :create, params: {
          post_id: blog_post.id, comment: FactoryBot.attributes_for(
            :comment, body: ""
          )
        }
      end

      it "renders the new comment form" do
        is_expected.to render_template :new
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:error]).to have_content("Unable to post comment.")
      end

      it "doesn't send a notification to the admin" do
        subject
        expect(Notification)
          .to_not have_received(:new_comment_admin_notification)
      end
    end
  end

  describe "GET #edit" do
    before do
      sign_in admin, scope: :user
      get(:edit, params: { id: valid_comment.id, post_id: blog_post.id })
    end

    it "assigns requested post to valid_comment" do
      expect(assigns(:comment)).to eq(valid_comment)
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
          id: valid_comment.id,
          post_id: blog_post.id,
          comment:  FactoryBot.attributes_for(
            :comment, body: 'hot take'
          )
        }
      end

      it "locates the requested valid_comment" do
        subject
        expect(assigns(:comment)).to eq(valid_comment)
      end

      it "changes valid_comment's body" do
        expect { put_attributes }
          .to change { Comment.find(valid_comment.id).body }
          .from(valid_comment.body).to('hot take')
      end

      it "redirects to the original post" do
        is_expected.to redirect_to blog_post
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:success]).to have_content('Your comment was updated successfully!')
      end
    end

    context "with invalid attributes" do
      subject(:put_attributes) do
        put :update, params: {
          id: valid_comment.id,
          post_id: blog_post.id,
          comment:  FactoryBot.attributes_for(
            :comment, body: ""
          )
        }
      end

      it "shouldn't change valid_comment's body" do
        expect { put_attributes }
          .to_not change { Comment.find(valid_comment.id).body }
      end

      it "renders the edit post" do
        is_expected.to render_template :edit
      end

      it "displays the correct flash message on redirect" do
        subject
        expect(flash[:error]).to have_content('Unable to edit comment.')
      end
    end
  end
end
