Given /^I have a habit with the first day set$/ do
  step 'I have a habit'

  today = Date.today
  month = today.month
  year = today.year
  @habit.habit_dates.create(date: Date.new(year, month, 1))
end

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

When /^I flag the first day of my habit$/ do
  visit angularize(habits_path)

  find(:xpath, "//tr/td[2]/input").click()
end

When /^I view my habits$/ do
  visit angularize(habits_path)
end

When /^I unflag the first day$/ do
  step "I flag the first day of my habit" # JWLL: Functionally the same thing, but with different set up
end

Then /^I should see that habit on my habits list$/ do
  visit angularize(habits_path)

  page.all(:css, 'tr.habit-row').length.should == 1
end

Then /^I should see the new description on my list of habits$/ do
  visit angularize(habits_path)

  page.should have_content('new description')
end

Then /^my habit should have the first day set$/ do
  visit angularize(habits_path)

  find(:xpath, "//tr/td[2]/input").should be_checked
end

Then /^my habit should have no set days$/ do
  visit angularize(habits_path)

  page.all(:css, 'tr.habit-row input').first.should_not be_checked
end
