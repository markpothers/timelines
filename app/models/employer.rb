class Employer < ApplicationRecord
  has_many :positions
  has_many :people, through: :positions
  has_many :cities, through: :positions
end
