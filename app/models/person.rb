class Person < ApplicationRecord
  has_many :positions
  has_many :cities, through: :positions
  has_many :employers, through: :positions

  has_many :events_as_visitor, :class_name => "Event", :foreign_key => "visitor_id"
  has_many :destinations_as_visitor, :through => :events_as_visitor, :source => :destination

  def sorted_positions
    self.positions.sort_by{|position|position.start_date}
  end

  def sorted_events
    self.events_as_visitor.sort_by{|event|event.start_date}
  end

  def find_overlap(my_position, their_position)
    if my_position.start_date >= their_position.start_date
      last_start = my_position.start_date
    else
      last_start = their_position.start_date
    end
    if my_position.finish_date <= their_position.finish_date
      first_finish = my_position.finish_date
    else
      first_finish = their_position.finish_date
    end
    overlap = [last_start, first_finish]
  end

  def parallel_positions
    co_locations = []
    co_locations = co_locations.concat self.co_located(self.sorted_positions, Position)
    co_locations = co_locations.concat self.co_located(self.events_as_visitor, Position)
    co_locations = co_locations.concat self.co_located(self.sorted_positions, Event)
    co_locations = co_locations.concat self.co_located(self.events_as_visitor, Event)
    
  end

  def co_located(my_location, their_class)
    coincident_locations = []
    my_location.each do |location|

      if my_location == self.sorted_positions && their_class == Position
        their_locations = their_class.where("city_id = #{location.city.id}")-my_location
      elsif my_location == self.events_as_visitor && their_class == Position
        their_locations = their_class.where("city_id = #{location.destination.id}")-my_location
      elsif my_location == self.sorted_positions && their_class == Event
        their_locations = their_class.where("destination_id = #{location.city.id}")-my_location
      else my_location == self.events_as_visitor && their_class == Event
        their_locations = their_class.where("destination_id = #{location.destination.id}")-my_location
      end

      their_locations.each do |their_location|
        if location.start_date <= their_location.finish_date && location.finish_date >= their_location.start_date
          overlap = find_overlap(location, their_location)

      if their_class == Position
        coincident_locations << [their_location.person, their_location.city.name, overlap[0], overlap[1]]
      else
        coincident_locations << [their_location.visitor, their_location.destination.name, overlap[0], overlap[1]]
      end

        end
      end
    end
    coincident_locations
  end

  def timeline
    timeline = []
      self.positions.each do |p|
        timeline << ["Position", p.title, p.city.name, p.start_date, p.finish_date]
      end
      self.events_as_visitor.each do |e|
         timeline << ["Event", e.title, e.destination.name, e.start_date, e.finish_date]
      end
    timeline.sort_by{|item| item[3]}
  end

end