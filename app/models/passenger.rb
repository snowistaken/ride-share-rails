class Passenger < ApplicationRecord
  has_many :trips

  def total_spent(id)
    @passenger = Passenger.find_by(id: id)
    spent = []
    @passenger.trips.each do |trip|
      spent << trip.cost.to_f
    end

    return ((spent.sum) / 100).round(2)
  end

  def find_driver
    available_drivers = Driver.where(available: "true")
    first_driver = available_drivers.first
    if first_driver
      return first_driver
    else
      return nil
    end
  end
end
