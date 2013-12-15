When /^I create a habit$/ do
  visit angularize(habits_path)

  find(".add-habit").click
end

When /^I edit the habit description$/ do
  visit angularize(habits_path)
  find_by_id(@habit.id).click
  fill_in "habit#{@habit.id}", with: 'new description'

  page.execute_script("$(\"input[name='habit#{@habit.id}']\").submit()")
end

Then /^I should see that habit on my habits list$/ do
  visit angularize(habits_path)

  page.all(:css, 'tr.habit-row').length.should == 1
end

Then /^I should see the new description on my list of habits$/ do
  visit angularize(habits_path)

  page.should have_content('new description')
end
