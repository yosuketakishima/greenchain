class ResultsController < ApplicationController
  def index
    if logged_in?
     @units=current_user.units
    
     @day_from = params[:day_from]
        @day_to = params[:day_to]
        @deviations = Deviation.where(unit_id: @units).where(time: @day_from..@day_to)
        
        #発送
        @dispatch_number = Temperature.where(unit_id: @units).where(time: @day_from..@day_to).count
        @deviation_number = Deviation.where(unit_id: @units).where(time: @day_from..@day_to).count
        @deviation_rate = @deviation_number.to_f/@dispatch_number*100
    end
  end
end
