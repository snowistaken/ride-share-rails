class TripsController < ApplicationController

  class DriversController < ApplicationController

    def index
      @trips = Trip.all
    end
  
    def show
      id = params[:id].to_i
      @trip = Trip.find_by(id: id)
  
      if @trip.nil?
        head :not_found
        return
      end
    end
  
    def destroy
  
    end
  
    def new
      @trip = Trip.new(trip_params)
    end
  
    def create
      @trip = Trip.new(trip_params)
      if @trip.save
        redirect_to trip_path
        return
      else
        render :new
        return
      end
    end

  private
  
  def trip_params
    return params.require(:trip).permit(:id, :driver_id, :passenger_id, :date, :cost, :rating)
  end
end
