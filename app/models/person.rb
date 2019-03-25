class Person < ApplicationRecord
  has_many :positions
  has_many :cities, through: :positions
  has_many :employers, through: :positions

  has_many :events
  has_many :destinations, through: :events, foreign_key: "destination_id"
end
