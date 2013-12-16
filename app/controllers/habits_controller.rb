class HabitsController < ApplicationController
  layout "angular"

  before_filter :authenticate_user!

  def set_date
    habit = Habit.find(params[:id])
    date = Date.parse(params[:date])

    habit_date = habit.habit_dates.find_or_create_by_date(date)
    render nothing: true
  end

  def remove_date
    habit = Habit.find(params[:id])
    date = Date.parse(params[:date])

    habit_date = habit.habit_dates.find_by_date(date)
    habit_date.try(:destroy)

    render nothing: true
  end

  def index
    today = Date.today
    year = today.year
    month = today.month

    next_month = today.month+1
    next_month_year = year
    if next_month > 12
      next_month = 1
      next_month_year = next_month_year+1
    end
    last_day_of_month = (Date.new(next_month_year, next_month, 1) - 1.day)

    respond_to do |format|
      format.html
      format.json do
        habits = current_user.habits.map do |habit|
          habit_dates = habit.habit_dates

          {
            id: habit.id,
            description: habit.description,
            days: (1..last_day_of_month.day).map do |day| 
              habit.habit_dates.find do |habit_date| 
                habit_date.date == Date.new(year, month, day)
              end ? 1 : 0
            end
          }
        end
        render json: habits.to_json
      end
    end
  end

  def create
    habit = current_user.habits.create
    render json: habit.to_json
  end

  def update
    habit = current_user.habits.where(id: params[:id]).first
    habit.description = params[:description]
    habit.save

    render nothing: true
  end

  def destroy
    habit = Habit.find(params[:id])
    habit.destroy() if habit.user_id == current_user.id

    render nothing: true
  end
end