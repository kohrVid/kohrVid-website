require 'rails_helper'

RSpec.describe "Comment", type: :request do
  let(:user) { FactoryBot.create(:user, :reader) }
  let(:blog_post) { FactoryBot.create(:post) }

  def sign_in(a_user)
    visit login_path
    fill_in "Email", with: a_user.email
    fill_in "Password", with: a_user.password
    click_button "Log In"
  end


  before(:each) do
    blog_post
    sign_in(user)
  end

  it "must send a notification once a comment is posted" do
    visit post_path(blog_post)
    click_link "Post a comment"
    expect(current_path).to eql(post_new_comment_path(blog_post))
    editor = find(:xpath, '//div[@contenteditable="true"]')
    editor.set("This is a new comment")
    editor.native.send_keys(:return)
    click_button "Submit"

    expect(page).to have_content("Your comment was added successfully!")
    expect(last_email.to).to include(ENV['GMAIL_USERNAME'])
    expect(last_email.subject).to include(
      "New comment posted under '#{blog_post.title}'"
    )
  end
end
