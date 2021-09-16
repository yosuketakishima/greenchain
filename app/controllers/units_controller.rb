class UnitsController < ApplicationController
    def index
        @units=Unit.all
        @temperatures=Temperature.all
        gon.temperatures=Temperature.all
    end
    
    def show
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
