class AddEndedAtToHabit < ActiveRecord::Migration
  def change
    change_table :habits do |t|
      t.date :ended_at
    end
  end
end
