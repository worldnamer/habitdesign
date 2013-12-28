Given /^I have a someday habit$/ do
  @user.somedays.create(description: 'Some day I will habit')
end

When /^I create a someday$/ do
  visit angularize(habits_path)

  find(".add-someday").click

  page.should have_css('form')
end

Then /^I should not see any someday habits$/ do
  page.should_not have_css('tr.someday')
end

Then /^I should see my someday habit$/ do
  page.should have_css('tr.someday')
end
