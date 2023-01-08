require 'rails_helper'

RSpec.describe BrucycleService do 
  before(:each) do 
    @user_id = 62
  end 

  describe '#get_user' do 
    it 'gets user data' do 
      json = File.read('spec/fixtures/user_data.json')

      stub_request(:get, "http://localhost:3000/api/v1/user?")
        .to_return(status: 200, body: json)

      response = BrucycleService.get_user(@user_id, "Foken")
      data = response[:data]
      attributes = data[:attributes]
      
      expect(response).to be_a Hash
      expect(data).to have_key(:id)
      expect(data).to have_key(:type)
      expect(data).to have_key(:attributes)
      expect(attributes).to have_key(:username)
      expect(attributes).to have_key(:beers_drunk)
      expect(attributes).to have_key(:brubank)
      expect(attributes).to have_key(:tot_gas_money_saved)
      expect(attributes).to have_key(:tot_calories_burned)
      expect(attributes).to have_key(:tot_miles_biked)
    end
  end

  describe '#get_activities' do 
    it 'gets users activities' do 
      json = File.read('spec/fixtures/user_activities.json')

      stub_request(:get, "http://localhost:3000/api/v1/activities?")
      .to_return(status: 200, body: json)

      response = BrucycleService.get_activities(@user_id, "Foken")
      data = response[:data]
      
      expect(data).to be_a Array

      expect(data[0][:attributes]).to eq({:date=>"2023-01-04T21:20:44.000Z", :title=>"Afternoon Run", :miles=>0.023125, :calories_burned=>1.15, :gas_money_saved=>0.0029, :beers_banked=>0.0007})
      expect(data[1][:attributes]).to eq({:date=>"2023-01-04T21:10:00.000Z", :title=>"Afternoon Run", :miles=>3.0175, :calories_burned=>150.89999999999998, :gas_money_saved=>0.3896, :beers_banked=>0.0917})
    end
  end
end