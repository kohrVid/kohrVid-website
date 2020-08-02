require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user1) { FactoryBot.create(:user, :reader_one) }
  let(:user2) { FactoryBot.create(:user, :reader_two) }

  def sign_in(a_user)
    visit login_path
    fill_in "Email", with: a_user.email
    fill_in "Password", with: a_user.password
    click_button "Log In"
  end

  before(:each) do
    admin
    user1
    user2
  end

  describe "#show" do
    context "anonymous user" do
      before do
        sign_in(user1)
        visit user_path(user1)
      end

      it "redirect if user isn't signed in" do
        expect(page).to have_content(user1.name)
        expect(page).to have_content(user1.email)
        expect(page).to have_content(user1.bio)
      end
    end

    context "current user" do
      before do
        sign_in(user1)
      end

      context "when visiting own profile" do
        before do
          visit user_path(user1)
        end

        it "should display user details" do
          expect(page).to have_content(user1.name)
          expect(page).to have_content(user1.email)
          expect(page).to have_content(user1.bio)
        end

        it "should display 'Update Account' link" do
          expect(page).to have_link(
            "Update Account",
            href: edit_user_registration_path
          )
        end
      end

      context "when visiting another profile" do
        before do
          visit user_path(user2)
        end

        it "should not display the user's email address" do
          expect(page).to have_content(user2.name)
          expect(page).to_not have_content(user2.email)
          expect(page).to have_content(user2.bio)
        end

        it "should not display 'Update Account' link" do
          expect(page).to_not have_link(
            "Update Account",
            href: edit_user_registration_path
          )
        end
      end
    end

    context "admin" do
      before do
        sign_in(admin)
        visit user_path(user1)
      end

      it "should display a user's details to an admin" do
        expect(page).to have_content(user1.name)
        expect(page).to have_content(user1.email)
        expect(page).to have_content(user1.bio)
      end
    end


    describe "Previous Conmments" do
      let(:comment) { FactoryBot.create(:comment, user_id: user1.id) }

      before do
       comment
        sign_in(user1)
        visit user_path(user1)
      end

      it "should display a link to the full comment" do
        expect(page).to have_link(
          "Posted under \"#{comment.post.title}\"",
          href: "/blog/posts/#{comment.post.id}##{comment.id}"
        )
      end

      it "should not display HTML tags from the comment" do
        expect(page).to_not have_content("<p>")
        expect(page).to_not have_content("</p>")
      end
    end
  end
end
