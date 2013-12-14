Given(/^an anonymous user$/) do
  logout :user
end

Given(/^a user with an existing account$/) do
  @user = create(:user)
end

# Given(/^a user$/) do
#   @user = create(:user)
#   login_as @user
# end

# Given(/^I am an anonymous user$/) do
#   visit destroy_user_session_path
# end

# When(/^I sign up for an account$/) do
#   visit new_user_registration_path
#   fill_in 'user_email', with: 'test@example.org'
#   fill_in 'user_password', with: 'password'
#   fill_in 'user_password_confirmation', with: 'password'
#   click_button 'SIGN UP'
# end

# When(/^I sign up again$/) do
#   visit new_user_registration_path
#   fill_in 'user_email', with: 'test@example.org'
#   fill_in 'user_password', with: 'password'
#   fill_in 'user_password_confirmation', with: 'password'
#   click_button 'SIGN UP'
# end