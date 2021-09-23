class UnitsController < ApplicationController
    before_action :require_user_logged_in
    
    def index
    
         @units=current_user.units
         #ユニットごとに最新のレコードを1個取得する方法が不明→ユニットごとでグループ化して1個のレコードを取得している
         @temperature=Temperature.where(unit_id: @units)
         @temperatures=@temperature.group(:unit_id)
         @today=Time.zone.now.strftime("%A").downcase
     
    end
    
    def show
        
        @units=Unit.find(params[:id])
        @temperatures = Temperature.where(unit_id: params[:id])
        @today=Time.zone.now.strftime("%A").downcase
        
        temp= @temperatures.group(:time).sum(:temperature)
        upper = Unit.joins(:temperatures).where(unit: params[:id]).group(:time).sum(:upper_temperature)
        lower = Unit.joins(:temperatures).where(unit: params[:id]).group(:time).sum(:lower_temperature)
        
        @chart = [
         { name: "温度", data: temp },
         { name: "上限", data: upper },
         { name: "下限", data: lower },
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
        redirect_to @units
        
    end
    
    def results
        
        @day_from = params[:day_from]
        @day_to = params[:day_to]
        @deviations = Deviation.where(unit_id: params[:id]).where(time: @day_from..@day_to)
        
        #dispatch_number（発送数）は検索した日が稼働日の場合はカウント、不稼働日の場合は非カウントで計算する仕様だが今回は実装ができず次の課題とする
        #dispatch_number（発送数）は検索した期間に発生したレコードの数で仮置きしている
        @dispatch_number = Temperature.where(unit_id: params[:id]).where(time: @day_from..@day_to).count
        @deviation_number = Deviation.where(unit_id: params[:id]).where(time: @day_from..@day_to).count
        @deviation_rate = @deviation_number.to_f/@dispatch_number*100
        
        @units=Unit.find(params[:id])
        @temperatures = Temperature.where(unit_id: params[:id]).where(time: @day_from..@day_to)
        
        temp= @temperatures.group(:time).sum(:temperature)
        upper = Unit.joins(:temperatures).where(unit: params[:id]).where(temperatures: {time: @day_from..@day_to}).group(:time).sum(:upper_temperature)
        lower = Unit.joins(:temperatures).where(unit: params[:id]).where(temperatures: {time: @day_from..@day_to}).group(:time).sum(:lower_temperature)
        
        @chart = [
         { name: "温度", data: temp },
         { name: "上限", data: upper },
         { name: "下限", data: lower },
        ]
   
    end
    
    private
    
    def unit_params
        params.require(:unit).permit(:origin, :destination, :owner, :departure_time, :arrival_time,
        :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday,
        :upper_temperature, :lower_temperature)
    end

end
