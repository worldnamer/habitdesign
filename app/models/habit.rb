class Habit < ActiveRecord::Base
  attr_accessible :description

  belongs_to :user

  has_many :habit_dates

  # date: ended_at

  def end
    update_attribute(:ended_at, Date.today)
  end

  def self.active(time=Time.now)
    where(ended_at: nil).where('created_at <= ?', time)
  end
end