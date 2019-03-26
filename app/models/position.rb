class Position < ApplicationRecord
  belongs_to :city
  belongs_to :employer
  belongs_to :person

  accepts_nested_attributes_for :person
  accepts_nested_attributes_for :employer
  accepts_nested_attributes_for :city


  # def person=(name)
  #   self.person_id = Person.find_or_create_by(name).id
  # end

  # def employer=(name)
  #   self.employer_id = Employer.find_or_create_by(name).id
  # end

  # def city=(name)
  #   self.city_id = City.find_or_create_by(name).id
  # end

end
