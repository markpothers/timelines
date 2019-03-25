class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.string :title
      t.string :description
      t.datetime :start_date
      t.datetime :finish_date
      t.belongs_to :person, foreign_key: true
      t.belongs_to :employer, foreign_key: true
      t.belongs_to :city, foreign_key: true

      t.timestamps
    end
  end
end
