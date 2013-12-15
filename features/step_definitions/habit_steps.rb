When /^I create a habit$/ do
  @habit = @user.habits.create(description: 'Test')
end

Then /^I should see that habit on my habits list$/ do
  visit habits_path

  page.all(:css, 'tr.habit-row').length.should == 1
end
