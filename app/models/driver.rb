class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  def average_rating(id)
    @driver = Driver.find_by(id: id)
    ratings = []
    @driver.trips.each do |trip|
      ratings << trip.rating.to_f
    end
    return nil if ratings.empty?
    return (ratings.sum / ratings.length).round(2)
  end

  def total_earnings(id)
    @driver = Driver.find_by(id: id)
    profit = []
    @driver.trips.each do |trip|
      profit << (trip.cost.to_f - 1.65) * 0.8
    end

    return (profit.sum / 100).round(2)
  end
end
