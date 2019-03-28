class Event < ApplicationRecord
  belongs_to :visitor, class_name: "Person", :foreign_key => "visitor_id"
  belongs_to :destination, class_name: "City", :foreign_key => "destination_id"

  accepts_nested_attributes_for :visitor
  accepts_nested_attributes_for :destination


  def visitor=(name)
    self.visitor_id = Person.find_or_create_by(name: name).id
  end

  def destination=(name)
    self.destination_id = City.find_or_create_by(name: name).id
  end

  def duration
    seconds = self.finish_date - self.start_date
    self.yandm(seconds)
  end

end
