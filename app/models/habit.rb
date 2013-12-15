class Habit < ActiveRecord::Base
  attr_accessible :description

  belongs_to :user

  has_many :habit_dates
end