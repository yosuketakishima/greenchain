class ToppagesController < ApplicationController
  def index
    if logged_in?
     @units=current_user.units
     @temperatures=Temperature.where(unit_id: @units)
     #グループ化の必要あり
     #@temperature=Temperature.select(:id).where(unit_id: @units).maximum('created_at')
     #@temperatures=Temperature.where(id: @temperature)
     @today=Time.zone.now.strftime("%A").downcase
     gon.temperatures=Temperature.all
    end
    
  end
  
  def tests
      @temperatures=Temperature.all
      @today=Time.zone.now.strftime("%A").downcase
  end
      
end
