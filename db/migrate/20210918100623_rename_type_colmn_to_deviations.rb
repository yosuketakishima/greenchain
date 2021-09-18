class RenameTypeColmnToDeviations < ActiveRecord::Migration[6.1]
  def change
    rename_column :deviations, :type, :situation
  end
end
