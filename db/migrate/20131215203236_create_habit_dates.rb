class CreateHabitDates < ActiveRecord::Migration
  def change
    create_table :habit_dates do |t|
      t.date :date
      t.references :habit
    end

    add_index :habit_dates, [:habit_id, :date]
  end
end
