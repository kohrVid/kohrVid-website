Given(/^that a user is on the contact page$/) do
  visit contact_path
end


When(/^they click "([^"]*)"$/) do |button|
  click_on button
end

When(/^they fill in their name$/) do
  fill_in 'Name', with: 'Tobey Torres'
end

When(/^they fill in their email$/) do
  fill_in 'Email', with: 'ttorres@snakeriverconspiracy.com'
end

When(/^they fill in their message$/) do
  fill_in 'Message', with: 'ZOMG, love the site!!'
end

When(/^they fill in all of the fields of the contact form$/) do
  fill_in 'Name', with: 'Rick'
  fill_in 'Email', with: 'RRoll@4chan.com'
  fill_in 'Message', with: 'Never gonna give you up!'
  fill_in 'Nickname', with: 'RickRollz'
end


Then(/^they can see my contact details$/) do
  #TODO
  pending
  expect(page).to have_css("a", mail_to: "kohrVid@zoho.com")
  expect(page).to have_content("Twitter")
end

Then(/^the message is sent successfully$/) do
  last_email = ActionMailer::Base.deliveries.last
  expect(page).to have_content('Thank you for your message! I try to respond within 24hrs so you should hear from me soon.')
  expect(last_email.to).to include(ENV['GMAIL_USERNAME'])
  expect(last_email.from).to include('ttorres@snakeriverconspiracy.com')
end

Then(/^the spam message isn't sent$/) do
  last_email = ActionMailer::Base.deliveries.last
  expect(page).to have_content('Unable to send message.')
  expect(last_email).to be_nil
end

Then(/^the message isn't sent$/) do
  last_email = ActionMailer::Base.deliveries.last
  expect(page).to have_content('Unable to send message.')
  expect(last_email).to be_nil
end
