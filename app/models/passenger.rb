class Passenger < ApplicationRecord
  has_many :trips

  def total_spent(id)
    @passenger = Passenger.find_by(id: id)
    spent = []
    @passenger.trips.each do |trip|
      spent << trip.cost
    end

    return spent.sum
  end
end
