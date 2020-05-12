class TripsController < ApplicationController

    def index
      if params[:passenger_id]
        passenger = Passenger.find_by(id: params[:passenger_id])
        @trips = passenger.trips
      else
        @trips = Trip.all
      end
    end

    def edit
      @trip = Trip.find_by(id: params[:id])
  
      if @trip.nil?
        head :not_found
        return
      end
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
      @trip = Trip.find_by(id: params[:id])

      if @trip.nil?
        head :not_found
        return
      else
        @trip.destroy
        redirect_to driver_path
      end
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
