require "test_helper"

describe PassengersController do
  
  let (:passenger) {
    Passenger.create name: "Passenger name", phone_num: "phone number"
  }

  describe "index" do
    # Your tests go here
    it "could get the index path" do
      
      get passengers_path

      must_respond_with :success
    end

    it "could get the root path" do
      
      get root_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "could get a valid passenger" do
      
      get passenger_path(passenger.id)

      must_respond_with :success
    end
   
    it "display not_found for an invalid passenger" do

      get passenger_path(0)

      must_respond_with :not_found
    end
  end

  describe "new" do

    it "can get the new passenger page" do
      get new_passenger_path
      must_respond_with :success
    end
    # Your tests go here
  end

  describe "create" do

    it "creates new passenger" do
      passenger_hash = {
        passenger: {
          name: "York", 
          phone_num: "4356784567"
        },
      }

      expect {
        post passengers_path, params: passenger_hash
      }.must_differ "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
   
  end

  describe "edit" do
    
    it "can get the edit for passenger" do
     get edit_passenger_path(passenger.id)

      must_respond_with :success
    end
    
    it "respond w/redirect when trying to edit nonexistent passenger" do
      

      get edit_passenger_path(-999)

      must_respond_with :not_found
    end
  end

  describe "update" do

    let (:new_passenger_hash) {
      {
        passenger: {
          name: "passenger name",
          phone_num: "passenger phone num"
        },
      }
    }
    it "update valid passenger and redirect" do
      passenger = Passenger.create(name: "Habu", phone_num: "3424564325")
      passenger_id = passenger.id
      
      update_hash = {
        passenger: {
          name: "Habu",
          phone_num: "3424564325"
        },
      }

      expect {
        patch passenger_path(passenger_id), params: update_hash
      }.wont_change "Passenger.count"
      
      updated_passenger = Passenger.find_by(id: passenger_id)
      
      expect(updated_passenger.name).must_equal update_hash[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal update_hash[:passenger][:phone_num]

      must_respond_with :redirect
    end

    it "give 404, when trying to update passenger w/invalid id" do
      invalid_id = -1

      update_hash = {
        passenger: {
          name: "Habulu",
          phone_num: "3424564325"
        },
      }

      expect {
        patch passenger_path(invalid_id), params: update_hash
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end
  end

  describe "destroy" do
    
    it "deletes @passenger in DB when passenger is already in DB" do
      
      passenger = Passenger.create(name: "Thom", phone_num: "4254567893")

      expect {
        delete passenger_path(passenger.id)
      }.must_differ "Passenger.count", -1

      must_respond_with :redirect
    end

    it "wont change DB for nonexistent passenger" do

      invalid_id = -1

      expect {
        delete passenger_path(invalid_id)
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end
  end
end
