class HabitDate < ActiveRecord::Base
  belongs_to :habit

  attr_accessible :date
end