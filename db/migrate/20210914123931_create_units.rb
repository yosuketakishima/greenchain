class CreateUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :units do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :unit
      t.string :origin
      t.string :destination
      t.string :owner
      t.time :departure_time
      t.time :arrival_time
      t.integer :monday
      t.integer :tuesday
      t.integer :wednesday
      t.integer :thursday
      t.integer :friday
      t.integer :saturday
      t.integer :sunday
      t.integer :upper_temperature
      t.integer :lower_temperature

      t.timestamps
    end
  end
end
