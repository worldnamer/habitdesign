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

  find(:xpath, "//tr/td[3]/input").click()
end

When /^I view my habits$/ do
  visit angularize(habits_path)
end

When /^I unflag the first day$/ do
  step "I flag the first day of my habit" # JWLL: Functionally the same thing, but with different set up
end

When /^I remove my habit$/ do
  visit angularize(habits_path)

  find(:xpath, '//tbody/tr/td[1]').click
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

  find(:xpath, "//tr/td[3]/input").should be_checked
end

Then /^my habit should have no set days$/ do
  visit angularize(habits_path)

  page.all(:css, 'tr.habit-row input').first.should_not be_checked
end

Then /^I should have no habits$/ do
  visit angularize(habits_path)

  page.all(:css, 'tr.habit-row').length.should == 0
end

Then /^I should see the current month$/ do
  today = Date.today
  page.should have_content today.strftime("%B") # JWLL: Month name

  page.all(:css, 'th').length.should be > 28
end
