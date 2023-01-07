require 'rails_helper'

RSpec.describe UserFacade do 
  describe '#user' do 
    before(:each) do 
      @json = File.read('spec/fixtures/user_data.json')
      @user_id = 62
      stub_request(:get, "http://localhost:3000/api/v1/user?")
      .to_return(status: 200, body: @json)
    end 

    it 'creates a User object based on lifetime stats' do 
      user = UserFacade.user(@user_id, "foken")
      
      expect(user).to be_a UserStats

      expect(user.beers_drunk).to be_a Integer
      expect(user.brubank).to be_a Float
      expect(user.tot_calories_burned).to be_a Float
      expect(user.tot_gas_money_saved).to be_a Float
      expect(user.tot_miles_biked).to be_a Float
      expect(user.username).to be_a String
    end
  end 

  describe '#get_activities' do
    it 'gets users activites' do 
      json = File.read('spec/fixtures/user_activities.json')
      user_id = 62

      stub_request(:get, "http://localhost:3000/api/v1/activities")
        .to_return(status: 200, body: json)

      activities = UserFacade.get_activities(user_id, 'foken')
      activity = activities.first

      expect(activities).to all(be_a Activity)

      expect(activity.date).to be_a DateTime
      expect(activity.title).to be_a String
      expect(activity.miles).to be_a Float
      expect(activity.calories_burned).to be_a Float
      expect(activity.gas_money_saved).to be_a Float
      expect(activity.beers_banked).to be_a Float
    end
  end
end 