class Habit < ActiveRecord::Base
  attr_accessible :description, :started_at

  belongs_to :user

  has_many :habit_dates

  # date: started_at
  # date: ended_at

  before_save :initialize_started_at

  def end
    update_attribute(:ended_at, Date.today)
  end

  def self.active(time=Time.now)
    where(ended_at: nil).where('started_at <= ?', time)
  end

  private

  def initialize_started_at
    self.started_at ||= Date.today
  end
end