class City < ApplicationRecord
  has_many :positions
  has_many :employers, through: :positions
  has_many :people, through: :positions

  has_many :events_as_destination, :class_name => "Event", :foreign_key => "destination_id"
  has_many :visitors_as_destination, :through => :events_as_destination, :source => :visitor
end
