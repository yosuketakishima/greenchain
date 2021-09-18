class CreateDeviations < ActiveRecord::Migration[6.1]
  def change
    create_table :deviations do |t|
      t.references :unit, null: false, foreign_key: true
      t.timestamp :time
      t.float :temperature
      t.decimal :latitude
      t.decimal :longitude
      t.string :type

      t.timestamps
    end
  end
end
