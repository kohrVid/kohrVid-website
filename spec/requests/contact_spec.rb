require 'rails_helper'

RSpec.describe "Contact", type: :request, js: false do

  it "must send valid message using the Contact form" do
    visit contact_path
    fill_in "Name", with: "MagicS"
    fill_in "Email", with: "nangioWah@premiergaou.ci"
    fill_in "Message", with: "Hi there. Could you make the Premier Gaou site?"
    click_button "Send"
    expect(page).to have_content("Thank you for your message! I try to respond within 24hrs so you should hear from me soon.")
    expect(last_email.to).to include(ENV['GMAIL_USERNAME'])
    expect(last_email.from).to include("nangioWah@premiergaou.ci")
  end

  # TODO - fix this test
  xit "must not deliver spam" do
    visit contact_path
    fill_in "Name", with: "Rick"
    fill_in "Email", with: "RRoll@4chan.com"
    fill_in "Message", with: "Never gonna give you up!"
    find(:xpath, "//input[@id='contact_nickname']").set("")
    nickname = first('input#contact_nickname', visible: false)
    nickname.set("RickRollz")
    nickname.native.send_keys(:return)
    click_button "Send"
    expect(page).to have_content("Unable to send message")
    expect(last_email).to be_nil
  end

  context "Name" do
    it "must not send message without name" do
      visit contact_path
      fill_in "Name", with: ""
      fill_in "Email", with: "nangioWah@premiergaou.ci"
      fill_in "Message", with: "Hi there. Could you make the Premier Gaou site?"
      click_button "Send"
      expect(page).to have_content("Unable to send message")
      expect(page).to have_content("Name can't be blank")
      expect(last_email).to be_nil
    end

    it "must be at least 2 characters long" do
      visit contact_path
      fill_in "Name", with: "c"
      fill_in "Email", with: "nangioWah@premiergaou.ci"
      fill_in "Message", with: "Hi there. Could you make the Premier Gaou site?"
      click_button "Send"
      expect(page).to have_content("Unable to send message")
      expect(page).to have_content("Name is too short (minimum is 2 characters)")
      expect(last_email).to be_nil
    end

    it "must be no longer than 50 characters" do
      visit contact_path
      fill_in "Name", with: "c"*51
      fill_in "Email", with: "nangioWah@premiergaou.ci"
      fill_in "Message", with: "Hi there. Could you make the Premier Gaou site?"
      click_button "Send"
      expect(page).to have_content("Unable to send message")
      expect(page).to have_content("Name is too long (maximum is 50 characters)")
      expect(last_email).to be_nil
    end
  end

  context "Email Address" do
    it "must not send message without an email address" do
      visit contact_path
      fill_in "Name", with: "MagicS"
      fill_in "Email", with: ""
      fill_in "Message", with: "Hi there. Could you make the Premier Gaou site?"
      click_button "Send"
      expect(page).to have_content("Unable to send message")
      expect(page).to have_content("Email can't be blank")
      expect(last_email).to be_nil
    end

    it "must not exceed 255 characters" do
      visit contact_path
      fill_in "Name", with: "MagicS"
      fill_in "Email", with: "c"*241+"@premiergaou.ci"
      fill_in "Message", with: "Hi there. Could you make the Premier Gaou site?"
      click_button "Send"
      expect(page).to have_content("Unable to send message")
      expect(page).to have_content("Email is too long (maximum is 255 characters)")
      expect(page).to have_content("")
      expect(last_email).to be_nil
    end

    # TODO - test the field validation properly
    invalid_email_address = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com .@example.com foo@bar..com)
    invalid_email_address.each do |email_address|
      it "must not send message without a valid email address" do
        visit contact_path
        fill_in "Name", with: "MagicS"
        fill_in "Email", with: email_address
        fill_in "Message", with: "Hi there. Could you make the Premier Gaou site?"
        click_button "Send"
        expect(page).to_not have_content("Thank you for your message! I try to respond within 24hrs so you should hear from me soon.")
        expect(last_email).to be_nil
      end
    end

    valid_email_address = %w(user@example.com USER@foo.COM A_US-ER@Foo.bar.org first.last@foo.jp alice+bob@baz.cn user@an.example.com 12@example.com)
    valid_email_address.each do |email_address|
      it "must send valid message using the Contact form if a valid email address is given" do
        visit contact_path
        fill_in "Name", with: "MagicS"
        fill_in "Email", with: email_address
        fill_in "Message", with: "Hi there. Could you make the Premier Gaou site?"
        click_button "Send"
        expect(page).to have_content("Thank you for your message! I try to respond within 24hrs so you should hear from me soon.")
        expect(last_email.to).to include(ENV['GMAIL_USERNAME'])
        expect(last_email.from).to include(email_address)
      end
    end
  end

  context "Message" do
    it "must not send message without message" do
      visit contact_path
      fill_in "Name", with: "MagicS"
      fill_in "Email", with: "nangioWah@premiergaou.ci"
      fill_in "Message", with: ""
      click_button "Send"
      expect(page).to have_content("Unable to send message")
      expect(page).to have_content("Message can't be blank")
      expect(last_email).to be_nil
    end
  end
end
