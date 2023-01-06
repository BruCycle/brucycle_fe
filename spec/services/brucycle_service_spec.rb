require 'rails_helper'

RSpec.describe BrucycleService do 
  before(:each) do 
    @json = File.read('spec/fixtures/user_data.json')
    @user_id = 62
  end 

  it 'gets user data' do 
    stub_request(:get, "http://localhost:3000/api/v1/user?")
      .to_return(status: 200, body: @json)

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