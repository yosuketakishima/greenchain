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
        Temperature.where(unit_id: params[:id], time: @day_from..@day_to).destroy_all
        
        flash[:success] = 'データ は正常に削除されました'
        redirect_to units_path
    end
    
    def results
        @day_from = params[:day_from]
        @day_to = params[:day_to]
        @deviations = Deviation.where(unit_id: params[:id]).where(time: @day_from..@day_to)
        
        #発送
        # @dispatch_number = Temperature.where(unit_id: params[:id]).where(time: @day_from..@day_to).count

        # https://docs.ruby-lang.org/ja/latest/class/Date.html
        @dispatch_number = (@day_from..@day_to).sum do |day|
                              temperature = Temperature.where(unit_id: params[:id]).where(time: day).first
                              unit = temperature.unit
  
                              case day.cwday
                                when 1 then return unit.monday
                                when 2 then return unit.tuesday
                                when 3 then return unit.wednesday
                                when 4 then return unit.thursday
                                when 5 then return unit.friday
                                when 6 then return unit.saturday
                                when 0 then return unit.sunday
                              end
                            end
    
        
        @deviation_number = Deviation.where(unit_id: params[:id]).where(time: @day_from..@day_to).count
        @deviation_rate = @deviation_number.to_f/@dispatch_number*100
        
        @units=Unit.find(params[:id])
        @temperatures = Temperature.where(unit_id: params[:id]).where(time: @day_from..@day_to)
        
        temp= @temperatures.group(:time).sum(:temperature)
        base = Unit.joins(:temperatures).where(unit: params[:id]).where(temperatures: {time: @day_from..@day_to}).group(:time).sum(:upper_temperature)
        
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
