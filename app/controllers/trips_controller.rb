class TripsController < ApplicationController
  def index
    if params[:passenger_id]
      @passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = @passenger.trips
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

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path
      return
    else
      render :edit
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

  def rating
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end

  def create
    @passenger = Passenger.find_by(id: params[:passenger_id])
    @driver = @passenger.find_driver

    trip_params = { driver_id: @driver.id, passenger_id: @passenger.id, date: Date.today, rating: 0, cost: rand(1..9999) }

    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trip_path(@trip.id)
      @driver.available = false
      @driver.save
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
