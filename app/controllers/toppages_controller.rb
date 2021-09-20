class ToppagesController < ApplicationController
  def index
    if logged_in?
     @units=current_user.units
     @temperatures=Temperature.where(unit_id: @units)
     gon.temperatures=Temperature.all
    end
    
  end
end
