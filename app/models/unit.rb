class Unit < ApplicationRecord
  belongs_to :user
  
  has_many :temperatures
  
  has_many :deviations
end
