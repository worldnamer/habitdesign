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
  end
end