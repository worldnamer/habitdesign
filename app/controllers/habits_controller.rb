class HabitsController < ApplicationController
  layout "angular"

  before_filter :authenticate_user!

  def index
    today = Date.today
    year = today.year
    month = today.month+1
    if month > 12
      month = 1
      year = year+1
    end
    last_day_of_month = (Date.new(year, month, 1) - 1.day)

    respond_to do |format|
      format.html
      format.json do
        habits = current_user.habits.map do |habit|
          {
            id: habit.id,
            description: habit.description,
            days: (1..last_day_of_month.day).map { 0 }
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
end