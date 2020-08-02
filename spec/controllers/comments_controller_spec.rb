require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user_id) { nil }

  let(:valid_comment) { FactoryBot.create(:comment, user_id: user_id) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user1) { FactoryBot.create(:user, :reader_one) }
  let(:user2) { FactoryBot.create(:user, :reader_two) }

  describe "GET #index" do
    subject do
      get(
        :index,
        params: { post_id: valid_comment.post.id, id: Comment.first.id }
      )
    end

    before do
      valid_comment
      subject
    end

    it "populates a hashtree with an existing comment" do
      expect(assigns(:comments)).to include(valid_comment)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    subject do
      get(
        :new,
        params: { post_id: valid_comment.post.id }
      )
    end

    context "as a signed-out user" do
      before(:each) do
        subject
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "as a non-admin user" do
      let(:user_id) { user1.id }

      before(:each) do
        sign_in user1, scope: :user
        subject
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "as an admin" do
      let(:user_id) { admin.id }

      before(:each) do
        sign_in admin, scope: :user
        subject
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST #create" do
    subject(:post_attributes) do
      post(
        :create,
        params: {
          post_id: valid_comment.post.id,
          comment: FactoryBot.attributes_for(:comment, user_id: user_id)
        }
      )
    end

    before do
      FactoryBot.create(:post)
    end

    context "as a signed-out user" do
      before(:each) do
        subject
      end

      it "redirects to the comments" do
        is_expected.to redirect_to post_path(valid_comment.post)
      end

      it "displays the correct flash message on redirect" do
        expect(flash[:success]).to have_content(
          "Your comment was added successfully!"
        )
      end
    end

    context "as a standard user" do
      let(:user_id) { user1.id }

      before(:each) do
        sign_in user1, scope: :user
      end

      context "with valid attributes" do
        it "locates the requested comment" do
          subject

          expect(assigns(:comment).body).to eq(valid_comment.body)
          expect(assigns(:comment).post).to eq(valid_comment.post)
          expect(assigns(:comment).user_id).to eq(valid_comment.user_id)
        end

        it "redirects to the new comment's post" do
          expect(post_attributes).to redirect_to post_path(valid_comment.post)
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:success]).to have_content(
            "Your comment was added successfully!"
          )
        end
      end

      context "with invalid attributes" do
        subject(:post_attributes) do
          post(
            :create,
            params: {
              post_id: valid_comment.post.id,
              comment: FactoryBot.attributes_for(:comment, body: nil, post_id: nil)
            }
          )
        end

        xit "shouldn't change the number of comments" do
          expect{ post_attributes }.to_not change { Comment.count }
        end

        it "renders the new comment template" do
          expect(post_attributes).to render_template :new
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:error]).to have_content("Unable to post comment.")
        end
      end
    end

    context "as an admin" do
      let(:user_id) { admin.id }

      before(:each) do
        sign_in admin, scope: :user
      end

      context "with valid attributes" do
        it "locates the requested comment" do
          subject

          expect(assigns(:comment).body).to eq(valid_comment.body)
          expect(assigns(:comment).post).to eq(valid_comment.post)
          expect(assigns(:comment).user_id).to eq(valid_comment.user_id)
        end

        it "redirects to the added comment's post" do
          expect(post_attributes).to redirect_to post_path(valid_comment.post)
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:success]).to have_content(
            "Your comment was added successfully!"
          )
        end
      end

      context "with invalid attributes" do
        subject(:post_attributes) do
          post(
            :create,
            params: {
              post_id: valid_comment.post.id,
              comment: FactoryBot.attributes_for(:comment, body: nil, post_id: nil)
            }
          )
        end

        xit "shouldn't change the number of comments" do
          expect{ post_attributes }.to_not change { Comment.count }
        end

        it "renders the new comment template" do
          expect(post_attributes).to render_template :new
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:error]).to have_content("Unable to post comment.")
        end
      end
    end
  end

  describe "GET #edit" do
    subject do
      get(
        :edit,
        params: { post_id: valid_comment.post.id, id: valid_comment.id }
      )
    end

    context "as a signed-out user" do
      before(:each) do
        subject
      end

      it "redirects to the comments" do
        is_expected.to redirect_to root_url
      end

      it "displays the correct flash message on redirect" do
        expect(flash[:error]).to have_content(
          "Sorry, you do not have access to that part of the site."
        )
      end
    end

    context "as the author" do
      let(:user_id) { user1.id }

      before(:each) do
        sign_in user1, scope: :user
        subject
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "as a non-author and non-admin" do
      let(:user_id) { user1.id }

      before(:each) do
        sign_in user2, scope: :user
        subject
      end

      it "redirects to the comments" do
        is_expected.to redirect_to root_url
      end

      it "displays the correct flash message on redirect" do
        expect(flash[:error]).to have_content(
          "Sorry, you do not have access to that part of the site."
        )
      end
    end

    context "as an admin" do
      let(:user_id) { admin.id }

      before(:each) do
        sign_in admin, scope: :user
        subject
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH #update" do
    let(:new_body) { "que?" }

    subject(:patch_attributes) do
      patch(
        :update,
        params: {
          post_id: valid_comment.post.id,
          id: valid_comment.id,
          comment: { body: new_body }
        }
      )
    end

    context "as a signed-out user" do
      before(:each) do
        valid_comment
        subject
      end

      it "redirects to the comments" do
        is_expected.to redirect_to root_url
      end

      it "displays the correct flash message on redirect" do
        expect(flash[:error]).to have_content(
          "Sorry, you do not have access to that part of the site."
        )
      end
    end

    context "as the author" do
      let(:user_id) { user1.id }

      before(:each) do
        sign_in user1, scope: :user
        valid_comment
      end

      context "with valid attributes" do
        it "locates the requested comment" do
          subject

          expect(assigns(:comment).post).to eq(valid_comment.post)
          expect(assigns(:comment).user_id).to eq(valid_comment.user_id)
        end

        it "changes comment's body" do
          expect{ patch_attributes }.to change {
            Comment.find(valid_comment.id).body
          }.to(new_body)
        end

        it "redirects to the updated comment's post" do
          expect(patch_attributes).to redirect_to post_path(valid_comment.post)
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:success]).to have_content(
            "Your comment was updated successfully!"
          )
        end
      end

      context "with invalid attributes" do
        let(:new_body) { "" }

        it "shouldn't change comment's body" do
          expect{ patch_attributes }.to_not change { Comment.find(valid_comment.id).body }
        end

        it "renders the edit comment" do
          expect(patch_attributes).to render_template :edit
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:error]).to have_content("Unable to update comment.")
        end
      end
    end

    context "as a non-author and non-admin" do
      let(:user_id) { user1.id }

      before(:each) do
        sign_in user2, scope: :user
        valid_comment
      end

      it "redirects to the comments" do
        expect(patch_attributes).to redirect_to root_url
      end

      it "displays the correct flash message on redirect" do
        subject

        expect(flash[:error]).to have_content(
          "Sorry, you do not have access to that part of the site."
        )
      end
    end

    context "as an admin" do
      let(:user_id) { admin.id }

      before(:each) do
        sign_in admin, scope: :user
        valid_comment
      end

      context "with valid attributes" do
        it "locates the requested comment" do
          subject

          expect(assigns(:comment).post).to eq(valid_comment.post)
          expect(assigns(:comment).user_id).to eq(valid_comment.user_id)
        end

        it "changes comment's body" do
          expect{ patch_attributes }.to change {
            Comment.find(valid_comment.id).body
          }.to(new_body)
        end

        it "redirects to the updated comment's post" do
          expect(patch_attributes).to redirect_to post_path(valid_comment.post)
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:success]).to have_content(
            "Your comment was updated successfully!"
          )
        end
      end

      context "with invalid attributes" do
        let(:new_body) { "" }

        it "shouldn't change comment's body" do
          expect{ patch_attributes }.to_not change { Comment.find(valid_comment.id).body }
        end

        it "renders the edit comment" do
          expect(patch_attributes).to render_template :edit
        end

        it "displays the correct flash message on redirect" do
          subject
          expect(flash[:error]).to have_content("Unable to update comment.")
        end
      end
    end
  end
end
