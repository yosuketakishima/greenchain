class UnitsController < ApplicationController
    def index
        @units=Unit.all
        @temperatures=Temperature.all
        gon.temperatures=Temperature.all
    end
    
    def show
        
        @units=Unit.find(params[:id])
        @temperatures = Temperature.where(unit_id: params[:id])
        
        temp= @temperatures.group(:time).sum(:temperature)
        base = Unit.joins(:temperatures).where(unit: params[:id]).group(:time).sum(:upper_temperature)
        
        @chart = [
         { name: "温度", data: temp },
         { name: "基準", data: base },
        ]
    end
    
    def edit
        @units=Unit.find(params[:id])
    end
    
    def update
        @units = Unit.find(params[:id])

        if @units.update(unit_params)
          flash[:success] = 'ユニット は正常に更新されました'
          redirect_to @units
        else
          flash.now[:danger] = 'ユニット は更新されませんでした'
          render :edit
        end
        
    end
    
    def destroy
        @day_from = params[:day_from]
        @day_to = params[:day_to]
        @memory = Temperature.find_by(unit_id: params[:id], time: @day_from..@day_to)
        @memory.destroy
        
        flash[:success] = 'データ は正常に削除されました'
        redirect_to units_path
        
    end
    
    def results
        @day_from = params[:day_from]
        @day_to = params[:day_to]
        @deviations = Deviation.where(unit_id: params[:id]).where(time: @day_from..@day_to)
        
        #発送
        @dispatch_number = Temperature.where(unit_id: params[:id]).where(time: @day_from..@day_to).count
        @deviation_number = Deviation.where(unit_id: params[:id]).where(time: @day_from..@day_to).count
        @deviation_rate = @deviation_number.to_f/@dispatch_number*100
        
        @units=Unit.find(params[:id])
        @temperatures = Temperature.where(unit_id: params[:id]).where(time: @day_from..@day_to)
        
        temp= @temperatures.group(:time).sum(:temperature)
        base = Unit.joins(:temperatures).where(unit: params[:id]).group(:time).sum(:upper_temperature)
        
        @chart = [
         { name: "温度", data: temp },
         { name: "基準", data: base },
        ]
    end
    
    private
    
    def unit_params
        params.require(:unit).permit(:origin, :destination, :owner, :departure_time, :arrival_time,
        :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday,
        :upper_temperature, :lower_temperature)
    end

end
