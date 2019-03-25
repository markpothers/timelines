class Position < ApplicationRecord
  belongs_to :city
  belongs_to :employer
  belongs_to :person
end
