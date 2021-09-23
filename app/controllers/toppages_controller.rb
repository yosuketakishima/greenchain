class ToppagesController < ApplicationController
    
  def index
    if logged_in?
     @units=current_user.units
     #ユニットごとに最新のレコードを1個取得する方法が不明→ユニットごとでグループ化して1個のレコードを取得している
     @temperature=Temperature.where(unit_id: @units)
     @temperatures=@temperature.group(:unit_id)
     @today=Time.zone.now.strftime("%A").downcase
    end
  end
  
end
