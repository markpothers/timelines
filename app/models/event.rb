class Event < ApplicationRecord
  belongs_to :visitor, class_name: "Person", :foreign_key => "visitor_id"
  belongs_to :destination, class_name: "City", :foreign_key => "destination_id"
end
