class AddStartedAtToHabit < ActiveRecord::Migration
  def change
    change_table :habits do |t|
      t.date :started_at
    end
  end
end
