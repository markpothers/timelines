class Position < ApplicationRecord
  belongs_to :city
  belongs_to :employer
  belongs_to :person


  def person=(name)
    self.person_id = Person.find_or_create_by(name: name).id
  end

  def employer=(name)
    self.employer_id = Employer.find_or_create_by(name: name).id
  end

  def city=(name)
    self.city_id = City.find_or_create_by(name: name).id
  end

end
