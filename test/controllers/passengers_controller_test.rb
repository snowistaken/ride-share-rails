require "test_helper"

describe PassengersController do
  describe "index" do
    # Your tests go here
    it "upon saving passenger, responds with success" do
      Passenger.create(name: "Em", phone_num: "2134567890")
      
      get "/passengers"

      must_responsd_with :success
    end

    it "also responds with success, if no passenger saved" do
      get "/passengers"

      must_responsd_with :success
    end
  end

  describe "show" do
    it "success when showing an existing valid passenger" do
      passenger = Passenger.create(name: "Em", phone_num: "2134567890")

      valid_id = passenger.id 
      get "/passengers/#{valid_id}"

      must_responsd_with :success

    end
    # Your tests go here
    it "gives 404 with invalid passenger_id" do
      
    invalid_id = -1

    get "/passengers/#{invalid_id}"

    must_responsd_with :not_found
    end
  end

  describe "new" do

    it "responsds with success" do
      get new_passenger_path
      must_responsd_with :success
    end
    # Your tests go here
  end

  describe "create" do

    it "creates new passenger w/valid params, and redirects" do
      passenger_hash = {
        passenger: {
          num: "York", 
          phone_num: "4356784567"
        },
      }

      expect {
        post passenger_path, params: passenger_hash
      }.must_differ "Passenger.count", 1

      passenger = Passenger.last
      expect(passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      must_redirect_to passenger_path(Passenger.find_by(name: "Asmera").id)
    end
    # Your tests go here
  end

  describe "edit" do
    
    it "responds w/success editing valid passenger" do
      passenger = Passenger.create(name: "Washington", phone_num: "2056743456")

      get edit_passenger_path(passenger.id)

      must_responsd_with :success
    end
    
    it "when requested to edit nonexistent passenger, responds with redirect" do
      invalid_id = -1

      get edit_passenger_path(invalid_id)

      must_responsd_with :not_found
    end
  end

  describe "update" do

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

      must_responsd_with :redirect
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

      must_responsd_with :not_found
    end
  end

  describe "destroy" do
    
    it "deletes @passenger in DB when passenger is already in DB" do
      
      passenger = Passenger.create(name: "Thom", phone_num: "4254567893")

      expect {
        delete passenger_path(passenger.id)
      }.must_differ "Passenger.count", -1

      must_responsd_with :redirect
    end

    it "wont change DB for nonexistent passenger" do

      invalid_id = -1

      expect {
        delete passenger_path(invalid_id)
      }.wont_change "Passenger.count"

      must_responsd_with :not_found
    end
  end
end
