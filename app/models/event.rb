class Event < ApplicationRecord
  belongs_to :visitor, class_name: "person"
  belongs_to :destination, class_name: "city"
end
