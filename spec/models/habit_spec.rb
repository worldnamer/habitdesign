require 'spec_helper'

describe Habit do
  it 'has dates' do
    habit = create(:habit)

    habit_date = habit.habit_dates.create(date: Date.today)

    habit.reload.habit_dates.should == [habit_date]
  end
end