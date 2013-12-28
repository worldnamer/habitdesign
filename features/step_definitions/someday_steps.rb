Given /^I have a someday habit$/ do
  @user = create(:user)
  @someday = @user.somedays.create(description: "description")

  login_as @user
end

When /^I create a someday$/ do
  visit angularize(habits_path)

  find(".add-someday").click

  page.should have_css('form')
end

When /^I remove my someday habit$/ do
  visit angularize(habits_path)

  find(:xpath, '//tbody/tr/td[1]').click
end

Then /^I should not see any someday habits$/ do
  page.should_not have_css('tr.someday')
end

Then /^I should see my someday habit$/ do
  page.should have_css('tr.someday')
end
