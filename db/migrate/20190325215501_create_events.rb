class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :start_date
      t.datetime :finish_date
      t.belongs_to :visitor
      t.belongs_to :destination

      t.timestamps
    end
  end
end
