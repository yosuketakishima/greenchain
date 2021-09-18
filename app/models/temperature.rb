class Temperature < ApplicationRecord
  belongs_to :unit
  
  after_create do
    if self.temperature > unit.upper_temperature
      deviation.create(
        unit. self.unit,
        time: self.time,
        temperature: self.temperature,
        latiitude: self.latitude,
        longitude: self.longitude,
        situation: 上限逸脱,
        )
    end
    
    if self.temperature < unit.upper_temperature
      deviation.create(
        unit. self.unit,
        time: self.time,
        temperature: self.temperature,
        latiitude: self.latitude,
        longitude: self.longitude,
        situation: 下限逸脱,
        )
    end
  end
  
end
