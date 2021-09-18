class Temperature < ApplicationRecord
  belongs_to :unit
  
  scope :results, -> (results_params) do
    return if results_params.blank?
    
    date_from(results_params[:date_from])
    .date_to(results_params[:date_to])
  end
  
  scope :date_from, -> (from) { where('? <= time', from) }
  scope :date_to, -> (to) { where('time <= ?', to) }
  
  def self.temperature_data
    order(time: :asc).pluck('time', 'temperature').to_h
  end
  
end
