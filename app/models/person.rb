class Person < ApplicationRecord
  has_many :positions
  has_many :cities, through: :positions
  has_many :employers, through: :positions

  has_many :events_as_visitor, :class_name => "Event", :foreign_key => "visitor_id"
  has_many :destinations_as_visitor, :through => :events_as_visitor, :source => :destination
end