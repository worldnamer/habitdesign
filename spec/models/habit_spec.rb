require 'spec_helper'

describe Habit do
  it 'has dates' do
    habit = create(:habit)

    habit_date = habit.habit_dates.create(date: Date.today)

    habit.reload.habit_dates.should == [habit_date]
  end

  it 'can be ended' do
    habit = nil

    Timecop.freeze(Date.new(2013, 1, 1)) do
      habit = create(:habit)
    end

    habit.end

    habit.reload.ended_at.should eq(Date.today)
  end

  it 'can filter to just active habits' do
    habit = create(:habit)
    create(:habit).end

    Habit.active.should == [habit]
  end

  it 'can filter active habits by a given date' do
    habit = nil
    Timecop.freeze(1.month.ago) do
      habit = create(:habit)
    end
    create(:habit).end

    Habit.active(1.week.ago).should == [habit]
  end
end