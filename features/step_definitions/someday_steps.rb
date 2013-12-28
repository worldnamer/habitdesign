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

When /^I edit the someday habit description$/ do
  visit angularize(habits_path)
  find_by_id(@someday.id).click
  fill_in "someday#{@someday.id}", with: 'new description'

  page.execute_script("$(\"input[name='someday#{@someday.id}']\").submit()")
end

Then /^I should see the new description on my list of someday habits$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should not see any someday habits$/ do
  page.should_not have_css('tr.someday')
end

Then /^I should see my someday habit$/ do
  page.should have_css('tr.someday')
end
