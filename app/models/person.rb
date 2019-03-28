class Person < ApplicationRecord
  has_many :positions
  has_many :cities, through: :positions
  has_many :employers, through: :positions

  has_many :events_as_visitor, :class_name => "Event", :foreign_key => "visitor_id"
  has_many :destinations_as_visitor, :through => :events_as_visitor, :source => :destination

  def sorted_positions
    self.positions.sort_by{|position|position.start_date}
  end

  def parallel_positions
    coincident_locations = []
    self.sorted_positions.each do |my_position|
      other_positions = Position.where("city_id = #{my_position.city.id}")-self.sorted_positions
      other_positions.each do |position|
        if my_position.city == position.city && my_position.start_date <= position.finish_date && my_position.finish_date >= position.start_date
            if my_position.start_date >= position.start_date
              last_start = my_position.start_date
            else
              last_start = position.start_date
            end
            if my_position.finish_date <= position.finish_date
              first_finish = my_position.finish_date
            else
              first_finish = position.finish_date
            end
          coincident_locations << [position, last_start, first_finish]
        end
      end
    end
    coincident_locations
  end

  def parallel_positions

    coincident_locations = [counterpart, city, overlapstart, overlapfinish]

    coincident_locations
  end
  

  def co_located
    coincident_locations = []



    self.sorted_positions.each do |my_position|
      other_positions = Position.where("city_id = #{my_position.city.id}")-self.sorted_positions
      other_positions.each do |position|
        if my_position.city == position.city && my_position.start_date <= position.finish_date && my_position.finish_date >= position.start_date
 byebug
          find_overlap(my_position, position)
          coincident_locations << [position, last_start, first_finish]
        end
      end
    end
    coincident_locations
  end







  def find_overlap(my_position, their_position)
    if my_position.start_date >= their_position.start_date
      last_start = my_position.start_date
    else
      last_start = position.start_date
    end
    if my_position.finish_date <= position.finish_date
      first_finish = my_position.finish_date
    else
      first_finish = position.finish_date
    end
    overlap = [last_start, first_finish]
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