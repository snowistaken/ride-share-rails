class PassengersController < ApplicationController

    def index
      @passengers = Passenger.all
    end
  
    def show
      id = params[:id].to_i
      @passenger = Passenger.find_by(id: id)
  
      if @passenger.nil?
        head :not_found
        return
      end
    end
  
    def edit
      @passenger = Passenger.find_by(id: params[:id])
  
      if @passenger.nil?
        head :not_found
        return
      end
    end
  
    def update
      @passenger = Passenger.find_by(id: params[:id])
  
      if @passenger.nil?
        head :not_found
        return
      elsif
        @passenger.update(passenger_params)
        redirect_to passenger_path
        return
      else
        render :edit
        return
      end
    end
  
    def destroy
      @passenger = Passenger.find_by(id: params[:id])

      if @passenge.nil?
        head :not_found
        return
      else
        @passenger.destroy
        redirect_to passenger_path
      end
    end
  
    def new
      @passenger = Passenger.new(passenger_params)
    end
  
    def create
      @passenger = Passenger.new(passenger_params)
      if @passenger.save
        redirect_to passenger_path
        return
      else
        render :new
        return
      end
    end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_number)
  end
end
