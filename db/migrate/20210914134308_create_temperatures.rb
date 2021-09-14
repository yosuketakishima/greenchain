class CreateTemperatures < ActiveRecord::Migration[6.1]
  def change
    create_table :temperatures do |t|
      t.references :unit, null: false, foreign_key: true
      t.timestamp :time
      t.float :temperature
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6

      t.timestamps
    end
  end
end
