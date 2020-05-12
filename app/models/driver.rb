class Driver < ApplicationRecord
  has_many :trips

  def average_rating(id)
    @driver = Driver.find_by(id: id)
    ratings = []
    @driver.trips.each do |trip|
      ratings << trip.rating.to_f
    end

    return (ratings.sum / ratings.length)
  end

  def total_earnings(id)
    @driver = Driver.find_by(id: id)
    profit = []
    @driver.trips.each do |trip|
      profit << (trip.cost.to_f - 1.65) * 0.8
    end

    return profit.sum
  end
end
