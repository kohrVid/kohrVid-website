require 'rails_helper'

RSpec.describe "Post", :type => :request do
  let(:draft_post) { FactoryBot.create(:post, draft: true, published_at: nil) }
  let(:admin) { FactoryBot.create(:user, :admin) }

  def sign_in(a_user)
    visit new_user_session_url
    fill_in "Email", with: a_user.email
    fill_in "Password", with: a_user.password
    click_button "Log In"
  end


  before(:each) do
    sign_in(admin)
  end

  context "@published" do
    it "should set the published_at date once draft is first unticked" do
      visit edit_post_path(draft_post)
      page.uncheck("post_draft")
      Timecop.freeze(Time.local(2016, 03, 21, 14, 10, 38))
      click_button "Submit"
      time = Time.now
      Timecop.return
      expect(page).to have_content("Post updated.")
      expect(Post.find(draft_post.id).draft).to be false
      expect(Post.find(draft_post.id).published_at).to eq(time)
    end

    it "should not set the published_at date if draft is unticked a second time" do
      visit edit_post_path(draft_post)
      page.uncheck("post_draft")
      Timecop.freeze(Time.local(2016, 03, 21, 14, 10, 38))
      click_button "Submit"
      time = Time.now
      recheck_time = Time.now + 5
      Timecop.return

      visit edit_post_path(draft_post)
      page.check("post_draft")
      Timecop.travel(recheck_time)
      click_button "Submit"
      second_uncheck_time = Time.now + 5
      Timecop.return

      visit edit_post_path(draft_post)
      page.uncheck("post_draft")
      Timecop.travel(second_uncheck_time)
      click_button "Submit"
      Timecop.return
      expect(Post.find(draft_post.id).draft).to be false
      expect(Post.find(draft_post.id).published_at).to eq(time)
      expect(Post.find(draft_post.id).published_at).to_not eq(recheck_time)
      expect(Post.find(draft_post.id).published_at).to_not eq(second_uncheck_time)
    end
  end
end
