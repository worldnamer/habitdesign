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
    if params[:startDate]
      start_date = Date.parse(params[:startDate])
    else
      start_date = Date.today
    end

    if params[:endDate]
      end_date = Date.parse(params[:endDate])
    else
      end_date = Date.today
    end

    respond_to do |format|
      format.html
      format.json do
        habits = current_user.habits.active(end_date).map do |habit|
          habit_dates = habit.habit_dates
          {
            id: habit.id,
            description: habit.description,
            days: start_date.upto(end_date).map do |date|
              habit.habit_dates.find do |habit_date| 
                habit_date.date == date
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