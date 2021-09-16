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
    end
end
