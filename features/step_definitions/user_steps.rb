Given(/^an anonymous user$/) do
  logout :user
end

Given(/^a user with an existing account$/) do
  @user = create(:user)
end

When(/^I sign up for an account$/) do
  visit new_user_registration_path
  fill_in 'user_email', with: 'test@example.org'
  fill_in 'user_password', with: 'password'
  fill_in 'user_password_confirmation', with: 'password'
  click_button 'Sign up'
end

When(/^I sign up again$/) do
  visit new_user_registration_path
  fill_in 'user_email', with: 'test@example.org'
  fill_in 'user_password', with: 'password'
  fill_in 'user_password_confirmation', with: 'password'
  click_button 'Sign up'
end