class CreateSomedaysTable < ActiveRecord::Migration
  def change
    create_table :somedays do |t|
      t.string :description

      t.references :user

      t.timestamps
    end

    add_index :somedays, :user_id
  end
end
