class Employee < ApplicationRecord
  validates :identification_number, presence: true, uniqueness: true
end
