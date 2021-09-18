class UnitsController < ApplicationController
    def index
        @units=Unit.all
        @temperatures=Temperature.all
        gon.temperatures=Temperature.all
    end
    
    def show
        @temperatures = Temperature.all
        @units=Unit.all
        
        temp= Temperature.group(:time).sum(:temperature)
        base = Unit.joins(:temperatures).group(:time).sum(:upper_temperature)
        
        @chart = [
         { name: "温度", data: temp },
         { name: "基準", data: base },
        ]
    end
    
    def edit
    end
    
    def update
    end
    
    def destroy
    end
    
    def results
        @results_params = temperature_results_params
        @temperatures = Temperature.results(@results_params)
    end
    
    private
    
    def temperature_results_params
    params.fetch(:results, {}).permit(:date_from, :date_to)
    end

end
