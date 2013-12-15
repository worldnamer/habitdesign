Given(/^I am unregistered$/) do
  logout :user
end

Given(/^I am a user$/) do
  @user = create(:user)
end

Given(/^I am logged-in$/) do
  @user = create(:user)

  login_as @user
end

Given(/^I have a habit$/) do
  @user = create(:user)
  @habit = @user.habits.create(description: "description")

  login_as @user
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