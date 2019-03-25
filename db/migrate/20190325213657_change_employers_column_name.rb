class ChangeEmployersColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :employers, :indsutry, :industry
  end
end
