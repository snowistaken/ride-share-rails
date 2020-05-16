require "test_helper"

describe TripsController do
  describe "show" do
    it "will get show for valid id" do
      driver = Driver.create(name: "Marta", vin: "RF5J464C70D9C3KBT")
      passenger = Passenger.create(name: "Leah", phone_num: "2060772909")
      trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 4, cost: 234)

      valid_trip_id = trip.id
      get "/trips/#{valid_trip_id}"
      must_respond_with :success
    end

    it "will respond with not_found for invalid_id" do
      invalid_trip_id = -1
      get "/trips/#{invalid_trip_id}"
      must_respond_with :not_found
    end
    # Your tests go here
  end

  describe "create" do
    it "can create a trip" do
      driver = Driver.create(name: "Yeni", vin: "RF5J464C70D9C3KBT", available: "true")
      passenger = Passenger.create(name: "Sam", phone_num: "2060772908")

      trip_hash = {
        trip: {
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Date.today,
          cost: 34,
        },
      }

      expect {
        post passenger_trips_path(passenger.id), params: trip_hash
      }.must_differ "Trip.count", 1

      expect(Trip.last.passenger_id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
    end

    # it "will not create a trip with invalid params" do
    #   trip_hash = {
    #     trip: {
    #       driver_id: nil,
    #       passenger_id: passenger.id,
    #       date: Date.today,
    #       cost: 45
    #     }
    #   }
    #   expect {
    #     post trips_path, params: trip_hash
    #   }.wont_change "Trip.count"

    #   must_respond_with :not_found
    # end

  end

  describe "edit" do
    it "succesfully edit and load" do
      driver = Driver.create(name: "Liya", vin: "RF5J464C70D9C3KBT")
      passenger = Passenger.create(name: "Calder", phone_num: "3456545678")
      trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 1, cost: 300)

      get "/trips/#{trip.id}/edit"
      must_respond_with :success
    end

    # Your tests go here
    it "can ge the edit page for trip" do
      driver = Driver.create(name: "Liya", vin: "RF5J464C70D9C3KBT")
      passenger = Passenger.create(name: "Calder", phone_num: "3456545678")
      trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 1, cost: 300)

      get edit_trip_path(trip.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistent trip" do
      get edit_trip_path(-9)
      must_respond_with :not_found
    end
  end

  describe "update" do
    let (:new_trip_hash) {
      {
        trip: {
          driver_id: Driver.first.id,
          passenger_id: Passenger.first.id,
          date: "Sun, 10 May 2020",
          rating: 2,
          cost: 23,
        },
      }
    }

    it "will update a model with a valid post request" do
      driver = Driver.create(name: "Liya", vin: "RF5J464C70D9C3KBT")
      passenger = Passenger.create(name: "Calder", phone_num: "3456545678")
      trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 1, cost: 300)

      valid_id = trip.id
      expect {
        patch trip_path(valid_id), params: new_trip_hash
      }.wont_change "Trip.count"

      updated_trip = Trip.find_by(id: valid_id)
      expect(updated_trip.driver_id).must_equal new_trip_hash[:trip][:driver_id]
      expect(updated_trip.passenger_id).must_equal new_trip_hash[:trip][:passenger_id]
      expect(updated_trip.date).must_equal new_trip_hash[:trip][:date]
      expect(updated_trip.rating).must_equal new_trip_hash[:trip][:rating]
      expect(updated_trip.cost).must_equal new_trip_hash[:trip][:cost]

      must_respond_with :redirect
    end

    it "will respond with not_found for invalid id" do
      invalid_id = -1
      expect {
        patch trip_path(invalid_id), params: new_trip_hash
      }.wont_change "Trip.count"
      must_respond_with :not_found
    end
  end

  describe "destroy" do
    driver = Driver.create(name: "Zoe", vin: "RF5J464C70D9C3KBT")
    passenger = Passenger.create(name: "Darin", phone_num: "4259872345")
    trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 4, cost: 25)

    it "destroys the trip instance in DB when trip exist, then redirect" do
      expect { delete trip_path(trip.id) }.must_differ "Trip.count", -1
    end

    it "does not change the DB when the trip does not exit, then responds with redirect" do
      invalid_id = -1
      expect { delete trip_path(invalid_id) }.wont_change "Trip.count"

      must_respond_with :not_found
    end
    # Your tests go here
  end
end
