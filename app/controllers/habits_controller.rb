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
    @days_in_month = last_day_of_month.day

    respond_to do |format|
      format.html
      format.json do
        render json: current_user.habits.to_json
      end
    end
  end

  def create
    habit = current_user.habits.create
    render json: habit.to_json
  end
end