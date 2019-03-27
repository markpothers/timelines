class Employer < ApplicationRecord
  has_many :positions
  has_many :people, through: :positions
  has_many :cities, through: :positions

  def sorted_positions
    self.positions.uniq.sort_by{|position|position.start_date}
  end

  def coworkers
    coworkers = []
      self.sorted_positions.each do |my_position|
        Position.all.each do |position|
          if my_position.employer == position.employer && my_position.start_date <= position.finish_date && my_position.finish_date >= position.start_date
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
            coworkers << [my_position, position, last_start, first_finish]
          end
        end
        coworkers.each do |coworker|
          coworkers.each do |other_coworker|
            if coworker[0] == other_coworker[1] && coworker[1] == other_coworker[0]
              coworkers.delete(other_coworker)
            end
          end
        end
      end
    coworkers
  end


end
