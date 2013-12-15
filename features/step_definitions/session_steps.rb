When(/^I log in with bad information$/) do
  visit new_user_session_path
  fill_in 'user_email', with: 'asd9fahsdf8234@gmail.com'
  fill_in 'user_password', with: 'garbage'
  click_button 'Sign in'
end

When(/^I log in to my account$/) do
  visit new_user_session_path
  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: @user.password
  click_button 'Sign in'
end

Then(/^I should get an account sign in error$/) do
  page.should have_content 'Invalid email or password'
end

Then(/^I should get an account creation error$/) do
  page.should have_content 'Email has already been taken'
end

Then(/^I should be logged in$/) do
  page.should have_content 'Signed in successfully'
end

Then(/^my account should be created$/) do
  page.should have_content 'Welcome! You have signed up successfully.'
end