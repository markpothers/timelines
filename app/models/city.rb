class City < ApplicationRecord
  has_many :positions
  has_many :employers, through: :positions
  has_many :people, through: :positions

  has_many :events
  has_many :visitors, through: :events, foreign_key: "visitor_id"
end
