class CreateEmployers < ActiveRecord::Migration[5.2]
  def change
    create_table :employers do |t|
      t.string :name
      t.string :indsutry
      t.string :size
      t.string :description
      t.string :products

      t.timestamps
    end
  end
end
