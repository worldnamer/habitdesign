class CreateHabitsTable < ActiveRecord::Migration
  def change
    create_table :habits do |t|
      t.string :description

      t.references :user

      t.timestamps
    end

    add_index :habits, :user_id
  end
end
