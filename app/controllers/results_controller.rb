class ResultsController < ApplicationController
  
  def index
    if logged_in?
     @units=current_user.units
    
        @day_from = params[:day_from]
        @day_to = params[:day_to]
        @deviations = Deviation.where(unit_id: @units).where(time: @day_from..@day_to)
        
        #dispatch_number（発送数）は検索した日が稼働日の場合はカウント、不稼働日の場合は非カウントで計算する仕様だが今回は実装ができず次の課題とする
        #dispatch_number（発送数）は検索した期間に発生したレコードの数で仮置きしている
        @dispatch_number = Temperature.where(unit_id: @units).where(time: @day_from..@day_to).count
        @deviation_number = Deviation.where(unit_id: @units).where(time: @day_from..@day_to).count
        @deviation_rate = @deviation_number.to_f/@dispatch_number*100
    end
  end
  
end
