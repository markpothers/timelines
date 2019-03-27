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
    coincident_positions = []
    other_positions = Position.all-self.sorted_positions
    self.sorted_positions.each do |my_position|
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
          coincident_positions << [position, last_start, first_finish]
        end
      end
    end
    coincident_positions
  end

end